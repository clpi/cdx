SHELL=/bin/sh
CC:=clang
CXX=clang++
CFLAGS:=-std=c99 -g `llvm-config --cflags`
CXXFLAGS=-std=c++20 -g `llvm-config --cxxflags`
LDFLAGS=`llvm-config --ldflags`
INSTALL=/usr/local/bin/install -c
IGNORE=-Wno-switch -Wno-builtin-macro-redefined -Wno-unused-value
FLAGS ?=
XFLAGS=-emit-llvm -emit-ast

CXXCMD=$(CXX) $(CXXFLAGS) $(LDFLAGS) $(XFLAGS) $(IGNORE)

OUTD := dist
BIND := $(OUTD)/bin
OBJD := $(OUTD)/obj
LIBD := $(OUTD)/lib
SRCD := src
BIN  := idx
SRC  := idx.cc

SRCF := $(SRCD)/$(SRC)
OUTB := $(BIND)/$(BIN)
OUTO := $(OBJD)/${BIN}.o

ARCH ?=
LLVM_CONFIG ?=

.PHONY: all

all: clean setup build run

%.o : %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
%.o : %.f
	$(COMPILE.F) $(OUTPUT_OPTION) $<

lib/%.o: lib/%.c
	$(CC) -fPIC -c $(CFLAGS) $(CPPFLAGS) $< -o $@

% :: RCS/%,v
	$(O) $(COFLAGS) $<

%.tab.c %.tab.h: %.y
	bison -d $<

clean:
	rm -rf $(OUTD)/*

setup:
	mkdir -p $(BIND)
	mkdir -p $(OBJD)
	mkdir -p $(LIBD)

build:
	$(CXX) $(CXXFLAGS) $(IGNORE) $(SRCF) -o $(OUTB)

run:
	@chmod u+x $(OUTB) && ./$(OUTB)

buildaddr:
	clang++ -g src/idx.cc -o dist/obj/idx.elf
	clang++ -g -O2 src/idx.cpp -o inlined.elf


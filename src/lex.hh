#include <iostream>
#include <string>
#include <algorithm>
#include <vector>

extern "C" inline int test() {
    return 123;
}

enum Cmd {
    help = 0,
    init = 1,
    run = 2,
    config = 3,
};

enum Position {
    file = 0,
    cmd = 1,
    args,
};

class MainCmd {
public:
    Cmd cmd = Cmd::help;

    static MainCmd parse(int argc, char* argv[]) {
        Cmd cmd = Cmd::help;
        for (int i=0; i < argc; ++i) {
            std::string arg = argv[i];
            switch (i) {
                case Position::file: continue;
                case Position::cmd:
                    if (arg ==  "init" || arg =="i") {
                        cmd = Cmd::init;
                    } else if (arg == "run" || arg == "r") {
                        cmd = Cmd::run;
                    } else if (arg == "config" || arg == "c") {
                        cmd = Cmd::config;
                    } else {
                        cmd = Cmd::help;
                    }
            }
        }
        return MainCmd{ cmd = cmd};
    }

    void exec(MainCmd self) {
        switch (self.cmd) {
            case Cmd::help : 
                printf("Help");
            case Cmd::init : 
                printf("Help");
            case Cmd::run : 
                printf("Help");
            case Cmd::config : 
                printf("Help");

        }

    }

};


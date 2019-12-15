import sys
import os
import subprocess

def printUsage():
    print(
'''Usage: nv [cd|ls|p|list|add|rm|help] ...
Navigate to directory bookmarks (named marks here)

Subcommands:
  cd <mark>                 navigate to mark
  ls <mark>                 list mark directory content
  p <mark>                  print mark
  list                      list all marks
  add <directory> <mark>    add a new mark
  rm <mark>                 remove mark
  help                      print this help
''')

class Navigator:
    def __init__(self, cd_fifo_fn, locations_fn):
        self.cd_fifo_fn = cd_fifo_fn
        self.locations_fn = locations_fn

        #create the file if it does not exist
        try:
            os.close(os.open(self.locations_fn, os.O_CREAT | os.O_EXCL | os.O_RDONLY))
        except OSError as e:
            if e.errno == os.errno.EEXIST:
                pass
            else:
                raise

    def checkNumArgs(self, subcommand, expected_num, args):
        if expected_num != len(args):
            print("Error: expected {} argument(s) for {}. Got {}".format(expected_num, subcommand,
                  len(args)), file=sys.stderr)
            printUsage()
            return False
        return True

    def help(self, args):
        printUsage()
        return True

    def cd(self, args):
        if not self.checkNumArgs("cd", 1, args):
            return None

        cd_mark = args[0]

        with open(self.locations_fn, "r") as f:
            for line in f:
                mark, location = line.split(" ", 1)
                if mark == cd_mark:
                    return location

        print("Mark {} not found".format(cd_mark), file=sys.stderr)
        return None

    def ls(self, args):
        if not self.checkNumArgs("ls", 1, args):
            return False

        ls_mark = args[0]

        with open(self.locations_fn, "r") as f:
            for line in f:
                mark, location = line.rstrip("\n").split(" ", 1)
                if mark == ls_mark:
                    print("{} is {}".format(mark, location))
                    subprocess.call(["ls", "--color=always", "-v", "--group-directories-first",
                                     location])
                    return True

        print("Mark {} not found".format(ls_mark), file=sys.stderr)
        return False

    def list(self, args):
        if not self.checkNumArgs("list", 0, args):
            return False

        with open(self.locations_fn, "r") as f:
            # each row has a mark and a dirpath
            table = [line.split() for line in f.readlines()]

            # display in readable table format
            # with mark at lest width 20 left aligned
            for row in table:
                print("{: <20} {}".format(*row))

        return True

    def p(self, args):
        if not self.checkNumArgs("p", 1, args):
            return False

        p_mark = args[0]

        with open(self.locations_fn, "r") as f:
            for line in f:
                mark, location = line.rstrip("\n").split(" ", 1)
                if mark == p_mark:
                    print(location)
                    return True

        print("Mark {} not found".format(p_mark), file=sys.stderr)
        return False

    def add(self, args):
        if not self.checkNumArgs("add", 2, args):
            return False

        path = args[0]
        mark = args[1]

        abs_path = os.path.abspath(path)

        with open(self.locations_fn, "r") as f:
            lines = f.readlines()

        with open(self.locations_fn, "w") as f:
            for line in lines:
                line = line.rstrip("\n")
                if line.split(" ", 1)[0] != mark:
                    f.write("{}\n".format(line))
            f.write("{} {}\n".format(mark, abs_path))

        return True

    def rm(self, args):
        if not self.checkNumArgs("rm", 1, args):
            return False

        mark = args[0]

        with open(self.locations_fn, "r") as f:
            lines = f.readlines()

        found = False
        with open(self.locations_fn, "w") as f:
            for line in lines:
                line = line.rstrip("\n")
                if line.split(" ", 1)[0] != mark:
                    f.write("{}\n".format(line))
                else:
                    found = True

        if not found:
            print("Mark {} not found".format(mark), file=sys.stderr)
            return False

        return True


subcommands = {
    "cd"      : Navigator.cd,
    "ls"      : Navigator.ls,
    "add"     : Navigator.add,
    "rm"      : Navigator.rm,
    "list"    : Navigator.list,
    "p"       : Navigator.p,
    "help"    : Navigator.help,
}


def nv(*args, **dargs):

    nav = Navigator(dargs['cd_fifo_fn'], dargs['locations_fn'])

    if (len(args) == 0):
        print("Error: no arguments.", file=sys.stderr)
        printUsage()
        return -1

    subcommand = args[0]

    if subcommand not in subcommands:
        print("Error: invalid subcommand.", file=sys.stderr)
        printUsage()
        return -1

    cd_loc = "."

    if subcommand != "cd":
        # non-cd subcommand
        ret = subcommands[subcommand](nav, args[1:])
    else:
        # cd command
        loc = nav.cd(args[1:])

        if loc is None:
            return -1

        cd_loc = loc
        ret = True

    if ret != True:
        return -1

    with open(nav.cd_fifo_fn, "w") as f:
        f.write(cd_loc)

    return 0






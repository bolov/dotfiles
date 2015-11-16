import sys
import os
import subprocess

def printUsage():
  print("Usage: nv [cd|ls|add|rm|list|p] ...")

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

  def checkNumArgs(self, subcommand, expecter_num, args):
    if expecter_num != len(args):
      print("Error: expected 1 argument for {}. Got {}".format(subcommand,
                                                               len(args)),
            file=sys.stderr)
      printUsage()
      return False
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
          subprocess.call(["ls", "--color=always", "-v",
                           "--group-directories-first", location])
          return True

    print("Mark {} not found".format(ls_mark), file=sys.stderr)
    return False

  def list(self, args):
    if not self.checkNumArgs("list", 0, args):
      return False

    with open(self.locations_fn, "r") as f:
      print(f.read(), end="")

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
    if not self.checkNumArgs("add", 1, args):
      return False

    mark = args[0]

    with open(self.locations_fn, "r") as f:
      lines = f.readlines()

    with open(self.locations_fn, "w") as f:
      for line in lines:
        line = line.rstrip("\n")
        if line.split(" ", 1)[0] != mark:
          f.write("{}\n".format(line))
      f.write("{} {}\n".format(mark, os.getcwd()))

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
  }


def nv(*args, **dargs):

  nav = Navigator(dargs['cd_fifo_fn'], dargs['locations_fn'])

  if (len(args) == 0):
    print("Error: no arguments.", file=sys.stderr)
    printUsage()
    return -1

  subcommand = args[0]

  cd_loc = "."

  if subcommand != "cd" and subcommand in subcommands:
    # non-cd subcommand
    ret = subcommands[subcommand](nav, args[1:])
  else:
    # cd command
    if subcommand == "cd":
      loc = nav.cd(args[1:])
    else:
      loc = nav.cd(args)

    if loc is None:
      return -1

    cd_loc = loc
    ret = True

  if ret != True:
    return -1

  with open(nav.cd_fifo_fn, "w") as f:
    f.write(cd_loc)

  return 0






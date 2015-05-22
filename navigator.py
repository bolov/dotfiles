from __future__ import print_function
import sys
import os

def printUsage():
  print("Usage: nv [cd|ls|add|rm|list|p] ...")

class Navigator:
  def __init__(self, cd_fifo_fn, locations_fn):
    self.cd_fifo_fn = cd_fifo_fn
    self.locations_fn = locations_fn

    #create the file if it does not exist
    try:
      with os.open(self.locations_fn, os.O_CREAT | os.O_EXCL | os.O_RDONLY) as f:
        pass
    except OSError as e:
      if e.errno == os.errno.EEXIST:
        pass
      else:
        raise

  def cd(self, args):
    if len(args) != 1:
      print("Error: expected 1 argument for cd. Got {}".format(len(args)),
            file=sys.stderr)
      return False

    cd_mark = args[0]

    with open(self.locations_fn, "r") as f:
      for line in f:
        mark, location = line.split(" ", 1)
        if mark == cd_mark:
          return location

    return None

  def ls(self, args):
    pass

  def list(self, args):
    if len(args) != 0:
      print("Error: too many arguments for list", file=sys.stderr)
      printUsage()
      return False

    with open(self.locations_fn, "r") as f:
      print(f.read())

    return True

  def add(self, args):
    if len(args) != 1:
      print("Error: expected 1 argument for add. Got {}".format(len(args)),
            file=sys.stderr)
      return False

    mark = args[0]

    with open(self.locations_fn, "r") as f:
      lines = f.readlines()

    with open(self.locations_fn, "w") as f:
      for line in lines:
        if line.split(" ", 1)[0] != mark:
          f.write("{}\n".format(line))
      f.write("{} {}".format(mark, os.getcwd()))

    return True


subcommands = {
    "cd":Navigator.cd,
    "ls":Navigator.ls,
    "add":Navigator.add,
    "rm":None,
    "list":Navigator.list,
    "p":None,
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
      print("Mark not found", sys.stderr)
      return -1

    cd_loc = loc
    ret = True

  if ret != True:
    return -1

  with open(nav.cd_fifo_fn, "w", 0) as f:
    f.write(cd_loc)

  return 0






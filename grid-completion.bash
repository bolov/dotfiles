#!/usr/bin/env bash

# prints all the queues
_grid_get_queues() {
  echo `qstat -g c | tail -n +3 | cut -f1 -d ' '`
}

# prints all the parallel environments
_grid_get_pes() {
  echo `qconf -spl`
}

_grid() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  if [ $COMP_CWORD -eq 2 ] && [ $prev = "-q" ] ; then
    if [ -z "$_grid_queues" ] ; then
      # cache the results
      _grid_queues=`_grid_get_queues`
    fi
    COMPREPLY=( `compgen -W "$_grid_queues" -- ${cur}` )
    return 0
  fi

  if [ $COMP_CWORD -eq 2 ] && [ $prev = "-pe" ] ; then
    if [ -z "$_grid_pes" ] ; then
      #cache the results
      _grid_pes=`_grid_get_pes`
    fi
    COMPREPLY=( `compgen -W "$_grid_pes" -- ${cur}` )
    return 0
  fi

  return 0
}

complete -o bashdefault -o dirnames -o filenames \
   -F _grid qsub
complete -o bashdefault -o dirnames -o filenames \
   -F _grid qlogin


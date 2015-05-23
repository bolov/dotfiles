#!/usr/bin/env bash

_nv_get_marks() {
  # locations file path
  local navigator_locations="$HOME/.navigator-locations"

  marks=""

  while read p ; do
    set -- $p
    marks+=" $1"
  done <$navigator_locations

  echo $marks
}

_nv()
{
  local cur prev subcmds subcmds_req_mark marks
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  subcmds="cd ls add rm list p repair"
  subcmds_req_mark="cd ls rm p"

  marks=`_nv_get_marks`

  if [ $COMP_CWORD -eq 1 ] ; then
    COMPREPLY=( $(compgen -W "${subcmds} ${marks}" -- ${cur}) )
    return 0
  fi

  if [ $COMP_CWORD -eq 2 ] && [[ $subcmds_req_mark =~ $prev ]] ; then
    COMPREPLY=( $(compgen -W "${marks}" -- ${cur}) )
    return 0
  fi
}
complete -F _nv nv


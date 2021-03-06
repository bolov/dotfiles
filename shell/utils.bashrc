#!/bin/bash

# utility functions for bash

source-if-ok() {
    for f in "$@" ; do
        if [ -f "$f" -a -r "$f" ] ; then
            source "$f"
        fi
    done
}

# cleans the delimiter colon `:` in an environment variable
# removes consecutives, first and last colon
clean-path() {
    if [ "$#" -ne 1 ] ; then
        >&2 echo "clean-path: Expected exactly 1 argument: variable name"
        return 1
    fi

    local var_name=$1
    eval local var_value=\$$var_name

    # sed -r enables extended regular expression: in this case `+`
    # sed -e run script
    #   1st: colapse consecutive `:`
    #   2nd: remove fist `:`
    #   3rd: remove last `:`
    var_value=`echo $var_value | sed -r -e 's/:+/:/g' -e 's/^://' -e 's/:$//'`
    export $var_name="$var_value"
}

# removes multiple paths separated by colon `:` from an environment variable
# usage: remove-path <env_var> <path1> <path2> ...
remove-path() {
    if [ "$#" -lt 1 ] ; then
        >&2 echo "remove-path: Expected argument: variable name"
        return 1
    fi

    local var_name=$1
    eval local var_value=\$$var_name

    shift # shift arguments

    # enclose in : to simplyfi sed command (make sure that we match a full elem)
    var_value=:"$var_value":

    # remove each path
    for path in "$@" ; do
        # use `:` as delimiter for sed as is cannot appear in a path (in $PATH etc.)
        var_value=`echo $var_value | sed 's:\:'"${path}"'\::\:\::g'`
    done

    export $var_name="$var_value"
    clean-path $var_name
    return 0
}


# usage: add-path [prepend-path | append-path] <env_var> <path1> <path2> ...
__add-path() {
    local which=$1
    shift # shift arguments

    if [ "$#" -lt 1 ] ; then
        >&2 echo "$which: Expected argument: variable name"
        return 1
    fi

    remove-path "$@"

    local var_name=$1
    eval local var_value=\$$var_name

    shift # shift arguments

    # add each path
    for path in "$@" ; do
        if [ ! -d "$path" ] ; then
            continue
        fi
        if [ $which = "prepend-path" ] ; then
            var_value="$path":"$var_value"
        elif [ $which = "append-path" ] ; then
            var_value="$var_value":"$path"
        fi
    done

    export $var_name="$var_value"
    clean-path $var_name
    return 0
}

# prepend multiple paths separated by colon `:` to an environment variable
# usage: prepend-path <env_var> <path1> <path2> ...
# each path is first removed if it already exists in env_var
# if a path doesn't exist it isn't added
prepend-path() {
    __add-path $FUNCNAME "$@"
}

# appends multiple paths separated by colon `:` to an environment variable
# usage: append-path <env_var> <path1> <path2> ...
# each path is first removed if it already exists in env_var
# if a path doesn't exist it isn't added
append-path() {
    __add-path $FUNCNAME "$@"
}




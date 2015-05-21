###### Aliases ####

alias ls='ls --color=auto -v --group-directories-first'
alias ls1='ls -1'

alias gvim-remote='gvim --remote'
alias grepi='grep -i'

alias cdp='cd -P'

if [ $HOSTNAME == "daedalus" ] ; then
  alias make='make -j8'
fi

# alias antlr-works='java -jar /usr/lib/antlr.3/antlrworks-1.4.3.jar'

###### Environment Variables #####

if [ -d "$HOME/scripts" ] ; then
  export PATH="$HOME/scripts:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
  export PATH="$HOME/bin:$PATH"
fi

export FEP=mihail.balan@fep.grid.pub.ro
export CELL=mihail.balan@cell.grid.pub.ro
export GPU=mihail.balan@gpu.grid.pub.ro

# export BOOST_ROOT=/usr/local/boost

# antlr3 jar file
# export CLASSPATH=/usr/lib/antlr.3/antlrworks-1.4.3.jar:$CLASSPATH

if [ $HOSTNAME == "cpl" ] ; then
  export PATH="/home/pk/llvm/install/bin:$PATH"

  export LD_LIBRARY_PATH="/home/pk/llvm/install/lib/:$LD_LIBRARY_PATH"
  export LD_LIBRARY_PATH="/home/pk/pocl/install/lib/:$LD_LIBRARY_PATH"
fi

if [ $HOSTNAME == "cpl" ] ; then
  export OPINCAA_ROOT="/home/pk/proiecte/opincaa"
  export OPINCAA_SIMULATOR_EXE="$OPINCAA_ROOT/simulator/build/simulator"
  # simulator working dir
  export OPINCAA_SIMULATOR_WD="$HOME/opincaa-simulator-wd"

  export POCL_DIR=/home/pk/pocl


  # SO2
  export QEMU_DIR="$HOME/ACS/SO2/qemu-vm"
fi

export FZF_DEFAULT_OPTS="-x"

### Functions ###

# function to mkdir and cd into it
mkcd() {
  mkdir -- "$1" && cd -- "$1"
}

# function to toggle the bash promp between cwd and basename of cwd
# it basically toggles the case of \w in $PS1
toggle-cwd-prompt() {
  local NEW_PS1
  # to upper
  NEW_PS1=$(echo "$PS1" | sed 's/\\w\\\$/\\W\\\$/')
  # if not substituted
  if [ "$PS1" = "$NEW_PS1" ]
  then
    # to lower
    NEW_PS1=$(echo "$PS1" | sed 's/\\W\\\$/\\w\\\$/')
  fi
  PS1=$NEW_PS1
}


### Settings ###

# needed here for fzf before source ~/.fzf.bash
set -o vi
# must be before bash_competion
# (or warning on auto completion for cmd starting with g++:
# bash: warning: programmable_completion: g++: possible retry loop)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# git completion
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

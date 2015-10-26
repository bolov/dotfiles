# Bolov Configs

Personal configuration files for Ubuntu.

## Files

#### Bash

- `bash_custom`
  - link: `~/.bash_custom`
  - ref by: `~/.bashrc`. Add:
    ````
    [ -f ~/.bash_custom ] && source ~/.bash_custom
    ````
  - TODO: make `.bashrc.d`

- `inputrc`
  - link: `~/.inputrc`

- `navigator.py`
  - link: `~/.navigator.py`
  - ref by: `bash_custom` (in function `nv` via local vars `navigator_py_*`)
  - TODO migrate to `.bashrc.d`

- `nv-completion`
  - link: `~/.bash-completion.d/nv-completion`
  - ref by: `bash_custom` (via ~/.bash-completion.d folder)

- `grid-completion`
  - link: `~/.bash-completion.d/grid-completion`
  - ref by: `bash_custom` (via ~/.bash-completion.d folder)

#### Vim

- `vimrc`

- `vimrc-linux-kernel`

- `mustang-bolov.vim`

### Clang, YouCompleteMe

- `ycm_extra_conf.py`
  - link: `~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py`
  - ref by: `vimrc` [vimrc](vimrc)

- `ycm_extra_conf_linux_kernel.py`

- `ycm_extra_conf_cuda.py`

- `ycm-cuda-hack.h`

- `clang-format`

- `clang-format-linux-kernel`

### Git

- `gitconfig`

### System

- `modulefiles`

### Other

- `zshrc`

README.md







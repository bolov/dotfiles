# Bolov Configs

Personal configuration files for Ubuntu.

## Files

#### Bash

- [profile-pk](profile-pk]
  - link: `~/.profile-pk`
  - ref by `~/.profile`. Add:
  ```
  [ -f "$HOME/.profile-pk" ] && source "$HOME/.profile-pk"
  ```

- [bash-pk](bash-pk)
  - link: `~/.bash-pk`
  - ref by: `~/.bashrc`. Add:
    ````
    [ -f ~/.bash-pk ] && source ~/.bash-pk
    ````
  - TODO: make `.bashrc.d`

- [inputrc](inputrc)
  - link: `~/.inputrc`

- [navigator.py](navigator.py)
  - link: `~/.navigator.py`
  - ref by: [bash-pk](bash-pk)
    (in function `nv` via local vars `navigator_py_*`)
  - TODO migrate to `.bashrc.d`

- [nv-completion](nv-completion)
  - link: `~/.bash-completion.d/nv-completion`
  - ref by: [bash-pk](bash-pk) (via `~/.bash-completion.d` folder)

- [grid-completion](grid-completion)
  - link: `~/.bash-completion.d/grid-completion`
  - ref by: [bash-pk](bash-pk) (via ~/.bash-completion.d folder)

#### Vim

- [vimrc](vimrc)

- [vimrc-linux-kernel](vimrc-linux-kernel)

- [mustang-bolov.vim](mustang-bolov.vim)

### Clang, YouCompleteMe

- [ycm_extra_conf.py](ycm_extra_conf.py)
  - link: `~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py`
  - ref by: [vimrc](vimrc) [vimrc](vimrc)

- [ycm_extra_conf_linux_kernel.py](ycm_extra_conf_linux_kernel.py)

- [ycm_extra_conf_cuda.py](ycm_extra_conf_cuda.py)

- [ycm-cuda-hack.h](ycm-cuda-hack.h)

- [clang-format](clang-format)

- [clang-format-linux-kernel](clang-format-linux-kernel)

### Git

- [gitconfig](gitconfig)

### System

- [modulefiles/](modulefiles/)

### Other

- [zshrc](zshrc)

# Bolov Configs

Personal configuration files for Ubuntu.

# Test

code block no syntax:

```
echo "string" <param>
```

code block Shell:

```Shell
echo "string" <param>
```

code block sh:

```sh
echo "string" <param>
```



## Files

#### Bash

- [bash_custom](bash_custom)
- [bash_custom]()
- [bash_custom][]
  - link: `~/.bash_custom`
  - ref by: `~/.bashrc`. Add:
    ````
    [ -f ~/.bash_custom ] && source ~/.bash_custom
    ````
  - TODO: make `.bashrc.d`

- [inputrc](inputrc)
  - link: `~/.inputrc`

- [navigator.py](navigator.py)
  - link: `~/.navigator.py`
  - ref by: [bash_custom](bash_custom)
    (in function `nv` via local vars `navigator_py_*`)
  - TODO migrate to `.bashrc.d`

- [nv-completion](nv-completion)
  - link: `~/.bash-completion.d/nv-completion`
  - ref by: [bash_custom](bash_custom) (via `~/.bash-completion.d` folder)

- [grid-completion](grid-completion)
  - link: `~/.bash-completion.d/grid-completion`
  - ref by: [bash_custom](bash_custom) (via ~/.bash-completion.d folder)

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

*please scuzați romgleza*

Linux: Settings, How To
=======================

**Table of contents**

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Ubuntu - system & settings](#ubuntu---system-&-settings)
  - [System settings](#system-settings)
  - [Compiz](#compiz)
  - [Nvidia drivers](#nvidia-drivers)
  - [Package Management](#package-management)
    - [Install `.deb`](#install-deb)
    - [Info](#info)
  - [File system](#file-system)
    - [Mount partitions](#mount-partitions)
- [OS](#os)
  - [File paths terminology](#file-paths-terminology)
- [Applications](#applications)
  - [BASH](#bash)
    - [Config files](#config-files)
  - [Git](#git)
    - [git bash completion](#git-bash-completion)
  - [Git Cheat Sheet](#git-cheat-sheet)
    - [Remote](#remote)
      - [Show remote url](#show-remote-url)
    - [Submodules](#submodules)
      - [Starting](#starting)
      - [Clone a proj with submodules:](#clone-a-proj-with-submodules)
      - [Working on a project with submodules](#working-on-a-project-with-submodules)
        - [Pulling in Upstream Change](#pulling-in-upstream-change)
        - [Workin on a submodule](#workin-on-a-submodule)
        - [Publishing Submodule Changes](#publishing-submodule-changes)
  - [VIM](#vim)
    - [Plugins](#plugins)
      - [Vundle](#vundle)
      - [clang complete](#clang-complete)
      - [Eclim](#eclim)
      - [buffkill](#buffkill)
      - [fzf](#fzf)
      - [YouCompleteMe](#youcompleteme)
      - [csope](#csope)
      - [ctags](#ctags)
      - [clang format](#clang-format)
  - [Apache Ant](#apache-ant)
    - [Install](#install)
  - [Chrome](#chrome)
  - [LastFM Scrobbler](#lastfm-scrobbler)
  - [ProjectM](#projectm)
  - [OSDLyrics](#osdlyrics)
  - [Music Brainz Picard](#music-brainz-picard)
  - [Cue Splitter](#cue-splitter)
  - [FZF](#fzf)
  - [OpenGL](#opengl)
  - [GCC](#gcc)
    - [Linking](#linking)
    - [Get gcc build options and default directories](#get-gcc-build-options-and-default-directories)
  - [gdb](#gdb)
  - [Environment Modules](#environment-modules)
    - [Install and first use](#install-and-first-use)
    - [Autocomplete bug:](#autocomplete-bug)
    - [Config](#config)
  - [BOOST (outdated)](#boost-outdated)
  - [ANTLR V3](#antlr-v3)
  - [Eclipse (outdated version & instructions)](#eclipse-outdated-version-&-instructions)
  - [Java libraries (outdated instructions)](#java-libraries-outdated-instructions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Ubuntu - system & settings
==========================

System settings
---------------

 - Personal ►

    - Appearance ► Laucher Icon Size: `32`
    - Security & Privacy ► Search ► Incluse Online Search Results: `OFF`
    - Language Suport >> Keyboard Input Method: `None` (disable ibus)


Compiz
------

```sh
sudo apt-get install compizconfig-settings-manager compiz-plugins-extra
```

- General Options ► Display Settings ►

  - Outputs:

    ```
    1500x1080+0+0
    420x1080+1500+0
    ```

  - Key bindings: `Maximize, Unmaximize orMinimize`

  - Desktop Size

- OpenGL ► Texture Filtering: play with if not working

- Enhanced Zoom Desktop: `Disable`

- Ubuntu Unity Plugin ► Switcher: `Disable all key bindings`

- Desktop Cube: `Enable` (Disable Desktop Wall)

- Desktop Wall: `Disable`

- Expo ► Appearance ►
  - Viewport Distance [0.00]
  - Inactive Viewports ►
    - Brightness `60`
    - Saturation `80`
  - Reflection `ON`

- Rotate Cube `Enable` ► General ► Raise on rotate `ON`

- Viewport Switcher `Disable`

- Scale Addons `Enable` ► Appearance ► Window Title Display: `All Windows`

- Scale Window Title Filter: `OFF`

- Workspace Naming `Enable` (Enable Text)

- Application Switcher [ENABLE]

- Grid

- Scale ► Appearance ► Overlay Icon: `Emblem`


Nvidia drivers
--------------

```sh
sudo add-apt-repository -y ppa:xorg-edgers/ppa
```

Where `-y`: assume yes to all queries

***!! 2 versiuni de nvidia instalate simultan = KABOOM !!***


resize bug:

workaround:

- Compiz ► Resize Window ► General ► Default Resize Mode: `Rectangle`


Package Management
------------------

### Install `.deb`

```sh
sudo dpkg -i file.deb
```

if errors with unresolved dependencies:

```sh
sudo apt-get install -f
```

### Info

For remote package

```sh
apt-cache show PACKAGE
```

For local package

```sh
dpkg -s PACKAGE
```

File system
-----------

### Mount partitions

dacă e montat (din Nautilus), see info:

```sh
mount
```

get uuid/label:

```sh
ls -al /dev/disk/by-uuid
ls -al /dev/disk/by-label
```


mount in /media/<uuid> (don't have udisks):

```sh
/usr/bin/udisks --mount /dev/disk/by-uuid/1313-F422
```

mount in /media/user/<uuid> (like nautilus):

```sh
udisksctl mount --block-device /dev/disk/by-uuid/<uuid>
```

automount on login:<br/>
from GUI: Startup Applications

OS
==

File paths terminology
----------------------


http://stackoverflow.com/q/2235173

| Name                   | /home/pk/foo.src        | /home/pk/dir/       |
|------------------------|-------------------------|---------------------|
| path                   | **/home/pk/foo.src**    | **/home/pk/dir**    |
| file path              | **/home/pk/foo.src**    | -                   |
| directory              | -                       | **/home/pk/dir**    |
| dirname<sup>Unix</sup> | <b>/home/pk/</b>foo.src | <b>/home/pk/</b>dir |
| basename<sup>Unix</sup>| /home/pk/**foo.src**    | /home/pk/**dir**    |
| filename               | /home/pk/**foo.src**    | -                   |
| stem <sup>*Boost*<sup> | /home/pk/**foo**.src    | -                   |
| extension              | /home/pk/foo<b>.src</b> | -                   |


Applications
============

BASH
----

### Config files

http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

When:

 - `~/.profile`: se execută la login: locally or ssh remote, etc.
                 Sigur pentru programe pornite cu dash
 - `~/.bashrc`: se execută când pornești un terminal, bash


What:

 - `~/.bash_profile` should be super-simple and just load `.profile` and
    `.bashrc` (in that order)

 - `~/.profile` has the stuff NOT specifically
    related to bash, such as environment variables (`PATH` and friends)

 - `~/.bashrc` has anything you'd want at an interactive command line.
    Command prompt, `EDITOR` variable, bash aliases for my use


Options pt (read) input (completion):

`~/.inputrc`


Git
---

### git bash completion

http://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks

https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

Git Cheat Sheet
---------------

### Remote

#### Show remote url

```sh
git config --get remote.origin.url
git remote show origin
git remote -v
git ls-remote --get-url origin
```

#### Rename

```sh
git remote rename old-name new-name
```

#### Add

```sh
git remote add name url
```

### Submodules

https://git-scm.com/book/en/v2/Git-Tools-Submodules

#### Starting

```sh
git submodule add link [name]
git diff --submodule
```

#### Clone a proj with submodules:

```sh
git clone link
git submodule init
git submodule update
```

or

```sh
git clone --recursive link
```

#### Working on a project with submodules

##### Pulling in Upstream Change

```sh
cd submodule-dir
git fetch
git merge origin/master
```

or

```sh
git submodule update --remote SubmoduleName
```

##### Workin on a submodule


```sh
cd submodule-dir
git checkout master
git submodule update --remote [--merge | --rebase]
```

##### Publishing Submodule Changes

```sh
git push --recursive-submodules=[check | on-demand]
```

### Rebase

```sh
git rebase <upstream> [<branch>]
```

#### Example 1


```
      A---B---C topic
     /
D---E---F---G master
```

```sh
git rebase master          # need to be on topic
git rebase master topic    # does a `checkout topic` first
```

```
              A'--B'--C' topic
             /
D---E---F---G master
```

#### Example 2

```
o---o---o---o---o  master
     \
      o---o---o---o---o  next
                       \
                        o---o---o  topic
```

```sh
git rebase --onto master next topic
```

```
o---o---o---o---o  master
    |            \
    |             o'--o'--o'  topic
     \
      o---o---o---o---o  next
```

### Workflow

#### Debug & Fix branches. Rebasing

```
M1---M2  master
     \
      D1---D2---D3  debug
                 \
                  F1---F2---F3  fix
```

```sh
git rebase --onto master debug fix
```

```
M1---M2  master
     | \
     |  F1'---F2'---F3' fix
      \
       D1---D2---D3  debug
```

```sh
git checkout master
git merge --ff-only fix
git branch -D fix
```

```
M1---M2---F1'---F2'---F3' master
      \
       D1---D2---D3  debug
```

```sh
git rebase master debug
```

```
M1---M2---F1'---F2'---F3' master
                       \
                        D1'---D2'---D3'  debug
```

SVN
---

Branches, tags and HEAD look apparently like folders:

```sh
> svn list http://llvm.org/svn/llvm-project/llvm/

branches/
tags/
trunk/
```

Checkout

```sh
svn checkout <url>
svn checkout <url>/trunk
```

list files / tags / branches

```sh
svn list <url> [--verbose]
snv list <url>/tags/
snv list <url>/branches/
```

VIM
----

### Plugins

#### Vundle

https://github.com/gmarik/Vundle.vim

```sh
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Local plugins with Vundle:
  - put in folder `~/opt/vim-plugins/`
  - script file needs to be in folder plugin
  - `git init && git add . && git commit`

e.g.:

```
~/opt/vim-plugins/buffkill/plugin/buffkill.vim
                          /.git/
```

in vundle:
```
Plugin 'file:///home/pk/opt/vim-plugins/bufkill'
```

#### clang complete

Install libclang:

```sh
sudo apt-get install libclang.so.1
sudo ln -s libclang.so.1 libclang.so
```

#### Eclim


Eclimd not installed in `/opt/eclipse` (as in instalation guide).<br>
Găsit în:<br>
`/home/pk/.eclipse/org.eclipse.platform_4.4.1_1473617060_linux_gtk_x86_64/eclimd`

Autostart on login:

`~/.config/autostart`
`.desktop` file to eclimd (cu gnome-desktop-item-edit)
(app, nu app in terminal)


#### buffkill

http://www.vim.org/scripts/script.php?script_id=1147 vundle nu poate de aici

https://github.com/vim-scripts/bufkill.vim e o clona (merge cu vundle) dar nu are ultima versiune (v 1.11) - e nevoie pentru disable mappings

făcut local (see Local plugins with Vundle)


#### fzf

See FZF as standalone

#### YouCompleteMe

prerequisites:

```sh
sudo apt-get install build-essential cmake python-dev
```

Compile:

```sh
cd ~/.vim/bundle/YouCompleteMe/
./install.sh --clang-completer
```

config file:

`~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py`


#### csope

Coming soon

#### ctags

Coming soon

#### clang format

Coming soon

Apache Ant
----------

### Install

```sh
sudo apt-get install ant
```


Chrome
------

http://www.ubuntuupdates.org/ppa/google_chrome

```sh
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
```

LastFM Scrobbler
----------------

http://apt.last.fm/

```sh
wget -q http://apt.last.fm/last.fm.repo.gpg -O- | sudo apt-key add -
```

  `/etc/apt/sources.list`  add:

```sh
deb http://apt.last.fm/debian stable main
```


```sh
sudo apt-get update
sudo apt-get install lastfm-scrobbler
```


ProjectM
--------


Milkdrop like visualization

  from software: projectM PulseAudio

  config:

`.projectM/config.inp`


OSDLyrics
---------

https://code.google.com/p/osd-lyrics/


Music Brainz Picard
-------------------

Music tagger


```sh
sudo add-apt-repository ppa:musicbrainz-developers/stable
```


Cue Splitter
------------

http://askubuntu.com/questions/521388/native-flac-cue-splitter

```sh
sudo apt-get install cuetools shntool
```

```sh
cuebreakpoints cue_file | shnsplit -o flac audio_flac_file

cuetag CUE_FILE split-track*.flac
```

--- Not tested

If error

> shnsplit: error: m:ss.ff format can only be used with CD-quality files

```sh
cuebreakpoints cue_file | sed s/$/0/ | shnsplit -o flac audio_flac_file>
```


FZF
---

https://github.com/junegunn/fzf

Install:

```sh
git clone --depth 1 https://github.com/junegunn/fzf.git fzf
./fzf/install
```

`[ -f ~/.fzf.bash ] && source ~/.fzf.bash` must be loaded after bash_completion.
So we can't have it in `shell/pk`.

Leave it in `~/.bashrc` as last instruction

`find` bug: infinte loop on symlinks.

Something inside `dosdevices` folders makes find run an infite loop when
executing with `-L` (follow symlinks). Fzf uses `-L` for autocomplete (`**`)

```sh
./.config/teamviewer10/dosdevices
./.local/share/wineprefixes/autohotkey/dosdevices
./.wine/dosdevices
```

Fix:

```sh
fzf/shell/completion.bash
```

add

```sh
-name dosdevices -prune -o
```

Before:


```sh
_fzf_path_completion() {
  __fzf_generic_path_completion \
    "-name .git -prune -o -name .svn -prune -o ( -type d -o -type f -o -type l )" \
    "-m" "" "$@"
}

_fzf_file_completion() {
  __fzf_generic_path_completion \
    "-name .git -prune -o -name .svn -prune -o ( -type f -o -type l )" \
    "-m" "" "$@"
}

_fzf_dir_completion() {
  __fzf_generic_path_completion \
    "-name .git -prune -o -name .svn -prune -o -type d" \
    "" "/" "$@"
}
```

After:

```sh
_fzf_path_completion() {
  __fzf_generic_path_completion \
    "-name dosdevices -prune -o -name .git -prune -o -name .svn -prune -o ( -type d -o -type f -o -type l )" \
    "-m" "" "$@"
}

_fzf_file_completion() {
  __fzf_generic_path_completion \
    "-name dosdevices -prune -o -name .git -prune -o -name .svn -prune -o ( -type f -o -type l )" \
    "-m" "" "$@"
}

_fzf_dir_completion() {
  __fzf_generic_path_completion \
    "-name dosdevices -prune -o -name .git -prune -o -name .svn -prune -o -type d" \
    "" "/" "$@"
}
```



OpenGL
------

```sh
sudo apt-get install freeglut3-dev
sudo apt-get install mesa-utils
```

GCC
---

### Linking

- `-L<path>`
- ex pt: `libboost_system.a` (`.so`):
  - static/dinamic (cred că alege el)
    - `-lboost_system`
  - static
    - `-l:libboost_system.a`
- contează ordinea: A depinde de B -> A înainte de B

### Get gcc build options and default directories

http://stackoverflow.com/questions/4980819/what-are-the-gcc-default-include-directories

```sh
gcc -xc++ -E -v -
```

### Install from sources

https://gcc.gnu.org/wiki/InstallingGCC
https://gcc.gnu.org/install/index.html

Prequisites:

```sh
sudo apt-get install libgmp-dev libmpfr-dev libmpc-dev
```

LLVM & clang
------------

### Install from source

http://llvm.org/docs/GettingStarted.html<br/>
http://llvm.org/docs/CMake.html

```
http://llvm.org/svn/llvm-project/llvm/
```

Latest is `trunk`

For a specific version checkout `tags/RELEASE_XXX/final`

#### Various

Targets supported:

Aparently:

`src/CMakeLists.txt:177`

```cmake
set(LLVM_ALL_TARGETS
  AArch64
  AMDGPU
  ARM
  BPF
  CppBackend
  Hexagon
  Mips
  MSP430
  NVPTX
  PowerPC
  Sparc
  SystemZ
  X86
  XCore
  )
```

If you run cmake with target all, all the targets will be listed


#### Example install 3.7.1 final

```sh
cd ~/opt/llvm
mkcd 3.7.1-final
svn checkout http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_371/final src
cd src/tools
svn checkout http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_371/final clang

cd ~/opt/llvm/3.7.1-final
mkcd build

cmake -G "Unix Makefiles" \
  -DCMAKE_INSTALL_PREFIX=/home/pk/opt/llvm/3.7.1-final/install-release/ \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_TARGETS_TO_BUILD="X86" \
  -- ../src

# free RAM!

make -j9
# ~23 min

make install
```

Note: `mkcd` = `mkdir` + `cd`

#### Extra: libclang Python bindings

found in

```sh
src/tools/clang/bindings/python
```

Are not installed in any way by building.

##### manual pseudo-install

```sh
cd ~/opt/llvm/<version>
mkdir -P <install>/other/libclang-python-bindings
cp -r src/tools/clang/bindings/python/clang <install>/other/libclang-python-bindings
```

add to `PYTHONPATH` (in llvm module maybe)

```sh
/home/pk/opt/llvm/3.7.1-final/install-release/other/libclang-python-bindings
```

### Check instalation

Compile flags? Include paths:

```sh
clang -E -x c++ -v  -  < /dev/null
```

Libraries:

```sh
ldd <executable>
objdump -p <executable> | grepi "needed"
```

### GNU vs LLVM C/C++ libraries

| Project       | C     | C++        |
|---------------|-------|------------|
| GNU (gcc)     | libc  | libstdc++  |
| LLVM (clang)  | ?     | libc++     |


gdb
---

pretty print stl (vectors)

de investigat cum am făcut: `~/.gdbinit`


Environment Modules
-------------------

### Install and first use

http://askubuntu.com/a/533636/255053

```sh
sudo apt-get install environment-modules
add.modules
```

in `.bashrc`: (lines added by `add.modules` and the beginning of the file)<br>
comment the first and uncomment the second. This should be the result:


```sh
#module() { eval `/usr/Modules/$MODULE_VERSION/bin/modulecmd $modules_shell $*`; }
module() { eval `/usr/bin/modulecmd $modules_shell $*`; }
```

```sh
source ~/.profile && source ~/.bashrc
```


### Autocomplete bug:

```sh
/etc/bash_completion.d/modules
```

wrong modulecmd path:

change (first with second)

```sh
/usr/share/modules/3.2.10/bin/modulecmd bash -t avail 2>&1 | sed '
/usr/bin/modulecmd bash -t avail 2>&1 | sed '
```

### Config

configs in `.profile` (e.g. `module use path, module load ...`).<br>
`modulerc` or whatnot: executed at each command


BOOST (outdated)
-----

- instalat in /usr/local/boost-1.56.0
- (atentie la dezarhivat) owner si group sa fie pk
- symlink boost -> boost-1.56.0
- export BOOST_ROOT=/usr/local/boost
- am dat ./bootstrap.sh fara niciun arg si a put totul in stage
- mutat in lib/x64
- adaugat path la linker (fară dă eroare la executabilele linkate dinamic):
  - creat fișier: (numele nu contează):
    /etc/ld.so.conf.d/libboost.conf
  - scris în el (nu merge cu $BOOST_ROOT)
    /usr/local/boost/lib/x64



ANTLR V3
--------

ANTLR v3.5.1 (from ANTRLworks 1.5.1) doesn’t work: broken java files (throws)

downloaded and copied into

```sh
/usr/lib/antl.v3
```

```sh
export CLASSPATH=/usr/lib/antlr.3/antlrworks-1.4.3.jar:$CLASSPATH
alias antlr-works='java -jar /usr/lib/antlr.3/antlrworks-1.4.3.jar'
```


Eclipse (outdated version & instructions)
-------

- unziped to /opt/Eclipse/
- created .Desktop file (app description for it);
  moved to `/home/pk/.local/share/applications/` to add it to the dash


Java libraries (outdated instructions)
--------------

Apache POI

- unziped to /usr/lib/apache-poi/

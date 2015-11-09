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
  - [File system](#file-system)
    - [Mount partitions](#mount-partitions)
- [Applications](#applications)
  - [BASH](#bash)
    - [Config files](#config-files)
  - [GIT](#git)
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
  - [Chrome](#chrome)
  - [LastFM Scrobbler](#lastfm-scrobbler)
  - [ProjectM](#projectm)
  - [OSDLyrics](#osdlyrics)
  - [Music Brainz Picard](#music-brainz-picard)
  - [FZF Fuzzy finder (outdated version)](#fzf-fuzzy-finder-outdated-version)
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

```Shell
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

```Shell
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

```Shell
sudo dpkg -i file.deb
```

if errors with unresolved dependencies:

```Shell
sudo apt-get install -f
```

File system
-----------

### Mount partitions

dacă e montat (din Nautilus), see info:

```Shell
mount
```

get uuid/label:

```Shell
ls -al /dev/disk/by-uuid
ls -al /dev/disk/by-label
```


mount in /media/<uuid> (don't have udisks):

```Shell
/usr/bin/udisks --mount /dev/disk/by-uuid/1313-F422
```

mount in /media/user/<uuid> (like nautilus):

```Shell
udisksctl mount --block-device /dev/disk/by-uuid/<uuid>
```

automount on login:<br>
from GUI: Startup Applications

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


GIT
---

git bash completion

http://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks

https://github.com/git/git/blob/master/contrib/completion/git-completion.bash


VIM
----

### Plugins

#### Vundle

https://github.com/gmarik/Vundle.vim

```Shell
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

```Shell
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

```Shell
sudo apt-get install build-essential cmake python-dev
```

Compile:

```
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


Chrome
------

http://www.ubuntuupdates.org/ppa/google_chrome

```Shell
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
```

LastFM Scrobbler
----------------

http://apt.last.fm/

```Shell
wget -q http://apt.last.fm/last.fm.repo.gpg -O- | sudo apt-key add -
```

  `/etc/apt/sources.list`  add:

```
deb http://apt.last.fm/debian stable main
```


```Shell
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


```Shell
sudo add-apt-repository ppa:musicbrainz-developers/stable
```


FZF Fuzzy finder (outdated version)
---------------------------

https://github.com/junegunn/fzf

just install

```Shell
git clone https://github.com/junegunn/fzf.git ~/.fzf
sudo ~/.fzf/install
```

dc eroare la install: error installing curses

```Shell
sudo apt-get install ruby-dev
sudo apt-get install libncurses5-dev
```

```Shell
export FZF_DEFAULT_OPTS="-x"
```

dc am shortcuturile cu CTRL-k pt history nu merge insertul decât dacă bash e
în vi mode

dacă în vi mode trebuie pus

```Shell
set -o vi
```

în `bashrc` înainte de

```Shell
source ~/.fzf.bash
```

As Vim Plugin

for gvim:

```Shell
let g:fzf_launcher='gnome-terminal --disable-factory -x bash -ic %s'
```


OpenGL
------

```Shell
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

```Shell
gcc -xc++ -E -v -
```



gdb
---

pretty print stl (vectors)

de investigat cum am făcut: `~/.gdbinit`


Environment Modules
-------------------

### Install and first use

http://askubuntu.com/a/533636/255053

```Shell
sudo apt-get install environment-modules
add.modules
```

in `.bashrc`: (lines added by `add.modules` and the beginning of the file)<br>
comment the first and uncomment the second. This should be the result:


```Shell
#module() { eval `/usr/Modules/$MODULE_VERSION/bin/modulecmd $modules_shell $*`; }
module() { eval `/usr/bin/modulecmd $modules_shell $*`; }
```

```Shell
source ~/.profile && source ~/.bashrc
```


### Autocomplete bug:

```Shell
/etc/bash_completion.d/modules
```

wrong modulecmd path:

change (first with second)

```Shell
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

```Shell
/usr/lib/antl.v3
```

```Shell
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

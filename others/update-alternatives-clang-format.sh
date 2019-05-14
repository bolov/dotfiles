#/usr/bin/bash

sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-6.0 600 \
    --slave /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-6.0 \
    --slave /usr/share/vim/addons/syntax/clang-format.py vim-clang-format.py /usr/share/vim/addons/syntax/clang-format-6.0.py

sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-7 700 \
    --slave /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-7 \
    --slave /usr/share/vim/addons/syntax/clang-format.py vim-clang-format.py /usr/share/vim/addons/syntax/clang-format-7.py



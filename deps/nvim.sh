#!/usr/bin/env bash

# Install vim-plug - https://github.com/junegunn/vim-plug
# NOTE: Run ':PlugInstall' in nvim after this.
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


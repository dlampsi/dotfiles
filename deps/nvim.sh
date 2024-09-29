#!/usr/bin/env bash

# Create nvim config directory since it doesn't exist by default.
mkdir -p "$HOME/.config/nvim"

# Install vim-plug - https://github.com/junegunn/vim-plug
# NOTE: Run ':PlugInstall' in nvim after this.
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

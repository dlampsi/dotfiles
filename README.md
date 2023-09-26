# dotfiles

[![Actions Status](https://github.com/dlampsi/dotfiles/workflows/checks/badge.svg)](https://github.com/dlampsi/dotfiles/actions)

Yet another dotfiles template repo with configuration scripts for personal use.

## Getting started

All you need to setup configs is a bash.

Setup files:
```bash
# Regular setup all dotfiles
./setup

# Force overwrite existwsing files
./setup -f

# Setup only zsh
./setup zsh

# Setup only zsh with force overwrite
./setup -f zsh
```

See all available options:
```bash
./setup -h
```

Check setup:
```bash
# Check installed alias
alias
# Check installed functions
declare -f
```

<!-- https://github.com/webpro/awesome-dotfiles -->

## Content

### Zsh

The [.zshrc](.zshrc) and [.zshenv](.zshenv) files will be updated for the configuration for the zsh.

They will automatically configure the loading of shell functions and aliases (described below).

### Aliases

Shell aliases are in the [.aliases](.aliases), which will be copied to the home directory during installation.

You can keep your local aliases in the `~/.aliases.local` file, they will be included automatically but won't be touched during the setup/update steps.

### Functions

Custom functions are in the [functions/](functions/) directory, they will be copied to the `~/.functions/` during the setup.

### Configs

The directory contains config files and scripts for various apps, such as tmux or vim.

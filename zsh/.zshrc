fpath+=("$(brew --prefix)/share/zsh/site-functions")

autoload -U promptinit; promptinit
# Pure - https://github.com/sindresorhus/pure
prompt pure
# PROMPT=" %{%F{yellow}%}%~ %f%}%# "

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions

# Load functions
[[ -f ~/.functions ]] && source ~/.functions

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Load completions
[[ -f ~/.zsh_completion ]] && source ~/.zsh_completion

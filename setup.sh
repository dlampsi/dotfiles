#!/usr/bin/env bash

set -e
set -o pipefail

CURDIR=$(pwd -P)
SYMLINKS_CFG="$CURDIR/symlinks.cfg"

BACKUP_DIR_BASE="$HOME/.dotfiles/backups"
BACKUP_DIR="$BACKUP_DIR_BASE/$(date '+%Y-%m-%d-%H%M%S')"

FILES=()

for arg in "$@"; do
  case $arg in
    -h|--help)
      echo "Setup dotfiles an configurations into local environment"
      echo " "
      echo "$0 [flags] files..."
      echo " "
      echo "flags:"
      echo "  -h, --help        Show brief help."
      echo "  -f, --forche      Force existing files overwrite."
      echo "  -b, --backup      Backup existing files before overwrite."
      echo "  --backup-dir      Backup directory. Default: $HOME/.dotfiles/backups"
      echo "  -t, --timestamps  Show timestamps in log output."
      echo "  -v, --verbose     Verbose script output."
      echo " "
      exit 0
    ;;
    -v|--verbose)
      VERBOSE=1
      shift
      ;;
    -f|--force)
      FORCE=1
      shift
      ;;
    -b|--backup)
      BACKUP=1
      shift
      ;;
    --backup-dir)
      BACKUP_DIR_BASE=$2
      shift 2
      ;;
    -t|--timestamps)
      TIMESTAMPS=1
      shift
      ;;
    *)
      FILES+=("$1")
      shift
      ;;
  esac
done

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
function log() {
  local lvl=$1
  local msg=$2
  local color=$3
  local no_color='\033[0m'

  if [[ -z $TIMESTAMPS ]]; then
    echo -e "${color}${lvl}${no_color} $msg"
  else
    local ts
    ts=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "$ts ${color}${lvl}${no_color} $msg"
  fi

}

function debug() {
  local color="\033[1;30m" # gray
  if [[ -n "$VERBOSE" ]]; then
    log "DEBUG" "$1" "$color"
  fi
}

function info() {
  local color='\033[0;32m' # green
  log "INFO " "$1" "$color"
}

function warn() {
  local color='\033[0;33m' # yellow
  log "WARN " "$1" "$color"
}

function error() {
  local color='\033[0;31m' # red
  log "ERROR" "$1" "$color"
  exit 1
}

function symlink() {
  local src=$1

  if ! grep -q "$src" "$SYMLINKS_CFG"; then
    warn "Can't get symlink configuration for '$src'"
    return
  fi

  cfg_line=$(< "$SYMLINKS_CFG" grep "$src")
  if [[ $cfg_line =~ ^# ]]; then
    warn "Symlink config line is commented for source: '$src'"
    return
  fi
  slink=$(echo "$cfg_line" | awk -F '=' '{print $2}')
  dst=$(eval echo "$slink")

  if [[ -f "$dst" ]] || [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
     # Checking if symlink already points to the source file
    real_path=$(realpath "$dst")
    if [[ "$real_path" == "$CURDIR/$src" ]]; then
      debug "[${src}] Symlink already valid"
      return
    fi

    if [[ -z $FORCE ]]; then
      warn "[${src}] File already exists: '$dst'"
      return
    fi

    if [[ -n $BACKUP ]]; then
      info "[${src}] Moving existing file to backup: '$dst'"
      dst_basename=$(basename "$dst")
      mv "$dst" "$BACKUP_DIR/$dst_basename.bak"
    else
      info "[${src}] Removing existing file resource"
      rm -rf "$dst"
    fi
  fi

  info "[${src}] Creating symlink: '$dst'"
  ln -s "$CURDIR/$src" "$dst"
}

# ------------------------------------------------------------------------------
# Main script
# ------------------------------------------------------------------------------
if [[ ! -f "$SYMLINKS_CFG" ]]; then
  error "Symlinks configuration file not found at: '$SYMLINKS_CFG'"
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  debug "Loading src files from symlinks config"
  # shellcheck disable=SC2034
  while IFS='=' read -r key value; do
    if [[ $key =~ ^# ]]; then
      debug "Skipping commented line: '$key'"
    else
      FILES+=("$key")
    fi
  done < "$SYMLINKS_CFG"
fi

if [[ -n $FORCE && -z $BACKUP ]]; then
  echo ""
  read -r -p "You're about to overwrite existing files without using the backup flag. Are you sure? (y/n): " answer
  if [[ $answer != "y" ]]; then
    exit 0
  fi
  echo ""
fi

if [[ -n $FORCE && -n $BACKUP ]]; then
  debug "Creating backup directory: $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
fi

info "Setting up dotfiles"

for src in "${FILES[@]}"; do
  symlink "$src"
done

info "All done"

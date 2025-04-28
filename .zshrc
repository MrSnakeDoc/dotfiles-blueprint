#!/bin/zsh
zmodload zsh/datetime
typeset -F SECONDS_REAL
SECONDS_REAL=$EPOCHREALTIME

# Load environment variables first!
[ -f "$HOME/dotfiles/.zsh/.zsh_env" ] && source "$HOME/dotfiles/.zsh/.zsh_env"

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# enable completion features
# Classic compinit setup, fast mode
autoload -Uz compinit
compinit -C -d ~/.cache/zcompdump

# Compile dump (1x au démarrage si besoin)
if [[ ! -f ~/.cache/zcompdump.zwc || ~/.cache/zcompdump -nt ~/.cache/zcompdump.zwc ]]; then
  zcompile ~/.cache/zcompdump
fi

# Clean and practical completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if [[ -n $SSH_CONNECTION ]]; then
      export TERM=xterm-256color
fi

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'



# Load core configurations
if [ -d "$DOTFILES_DIR" ]; then
    # Load Brew
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_brew ] && source "$DOTFILES_DIR/$ZSH_DIR"/.zsh_brew

    # Tools configuration (brew, asdf, atuin, syntax highlighting)
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_tools ] && source "$DOTFILES_DIR/$ZSH_DIR"/.zsh_tools

    # Git configuration
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_git_func ] && source "$DOTFILES_DIR/$ZSH_DIR"/.zsh_git_func

    # Load zsh plugins
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_plugins ] && source "$DOTFILES_DIR/$ZSH_DIR"/.zsh_plugins
    
    # Custom configurations
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_custom_config ] && source $DOTFILES_DIR/$ZSH_DIR/.zsh_custom_config
    
    # Aliases configuration
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_aliases ] && source "$DOTFILES_DIR/$ZSH_DIR"/.zsh_aliases

    # History configuration
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_history ] && source $DOTFILES_DIR/$ZSH_DIR/.zsh_history
    
    # Keybindings
    [ -f "$DOTFILES_DIR/$ZSH_DIR"/.zsh_keys ] && source $DOTFILES_DIR/$ZSH_DIR/.zsh_keys
fi

# Function to check and create hash file if it doesn't exist
function file_exists() {
    if [ ! -f "$HASH_FILE" ]; then
        echo "Creating hash file..."
        touch "$HASH_FILE"
        if [ -f "$ALIAS_FILE" ]; then
            current_hash=$(md5sum "$ALIAS_FILE" | cut -d' ' -f1)
            echo "$current_hash" > "$HASH_FILE"
        fi
    fi
}

# Function to check if aliases file has changed and reload it
function check_aliases_changes() {
    if [ -f "$ALIAS_FILE" ]; then
        current_hash=$(md5sum "$ALIAS_FILE" | cut -d' ' -f1)
        stored_hash=$(cat "$HASH_FILE" 2>/dev/null || echo "")

        if [ "$current_hash" != "$stored_hash" ]; then
            echo "🔄 Reloading aliases..."
            # Unalias all existing aliases
            unalias -a
            # Source the aliases file again
            source "$ALIAS_FILE"
            echo "$current_hash" > "$HASH_FILE"
        fi
    fi
}

# Initialize the hash file
file_exists

# Add functions to precmd_functions array
precmd_functions=(${precmd_functions[@]} "file_exists" "check_aliases_changes")

typeset -F END_REAL
END_REAL=$EPOCHREALTIME
DURATION=$(awk "BEGIN { printf \"%.3f\", $END_REAL - $SECONDS_REAL }")
echo "🚀 Shell loaded in ${DURATION}s"
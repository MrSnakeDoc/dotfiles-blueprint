#!/bin/bash

create_kitty=false

DOTFILES="${DOTFILES:-$HOME/dotfiles}"  # Allow override via env var
CONFIG="${CONFIG:-$HOME/.config}"  # Allow override via env var

while getopts "k" opt; do
  case $opt in
    k)
      create_kitty=true;;
    \?)
      echo "Usage: $0 [-k] (k: create symlink for kitty)"
      exit 1;;
  esac
done

# Create required directories
mkdir -p "$CONFIG"

create_symlink() {
  local source=$1
  local destination=$2

  if [ ! -e "$source" ]; then
      echo "Warning: Source $source does not exist"
      return 1
  fi


  if [ ! -d "$destination" ]; then
    # Create the destination directory if it doesn't exist
    echo "Creating directory for $destination"
    mkdir -p "$(dirname "$destination")"
  fi

  if [ -f "$destination" ] || [ -h "$destination" ]; then
    echo "$destination already exists. Deleting it..."
    rm "$destination"
  fi

  echo "Creating symlink from $source to $destination"
  ln -s "$source" "$destination"
}

create_symlink "$DOTFILES/.zshrc" "$HOME/.zshrc"

create_symlink "$DOTFILES/.config/keg" "$HOME/.config/keg"

create_symlink "$DOTFILES/.config/starship.toml" "$HOME/.config/starship.toml"

create_symlink "$DOTFILES/.config/zsh/_plugins" "$HOME/.zsh/completion/_plugins"


if $create_kitty; then
  create_symlink "$HOME/dotfiles/.config/kitty" "$HOME/.config/kitty"
fi

echo "Symlinks created successfully."
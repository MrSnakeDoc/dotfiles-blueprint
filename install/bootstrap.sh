#!/bin/bash

if ! [ -x "$(command -v zsh)" ]; then
  echo "Zsh is not installed. Installing zsh..."
  sudo apt update
  sudo apt install zsh -y
else
  echo "Zsh is already installed."
fi

echo "Making zsh the default shell..."
chsh -s $(which zsh)
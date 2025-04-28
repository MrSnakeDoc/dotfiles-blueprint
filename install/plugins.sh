#!/bin/zsh

install_asdf=false
import_history=false

while getopts "oah" opt; do
  case $opt in
    o)
      install_asdf=true;;
    a)
      import_history=true;;
    h)
      echo "Usage: $0 [-o] (o: install asdf and plugins) [-a] (a: import history to atuin) [-h] (h: help)"
      exit 1;;
  esac
done

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Define packages arrays
BREW_PACKAGES=(
  "eza"
  "starship"
  "zoxide"
  "fzf"
  "atuin"
  "bat"
  "btop"
)

BREW_CASK_PACKAGES=(
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
)

# Function to install brew package
install_brew_package() {
  local package=$1
  if ! command_exists "$package"; then
    echo "Installing $package..."
    brew install "$package"
  else
    echo "$package is already installed."
  fi
}

# Function to install brew cask package
install_cask_package() {
  local package=$1
  if ! brew list --cask "$package" &> /dev/null; then
    echo "Installing $package..."
    brew install "$package"
  else
    echo "$package is already installed."
  fi
}

# Install Homebrew if needed
if ! command_exists brew; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  source ~/.zshrc
else
  echo "Homebrew is already installed."
fi


echo "Starting installation of plugins..."

# Install asdf if requested
if [ "$install_asdf" = true ]; then
  if ! command_exists asdf; then
    echo "Installing asdf..."
    brew install asdf
    source ~/.zshrc
  else
    echo "asdf is already installed."
  fi

  echo "Installing asdf plugins..."
  if ! asdf plugin list | grep -q golang; then
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
  fi
  asdf install golang latest
  asdf global golang latest
fi

# Install standard packages
for package in "${BREW_PACKAGES[@]}"; do
  install_brew_package "$package"
done

# Install cask packages
for package in "${BREW_CASK_PACKAGES[@]}"; do
  install_cask_package "$package"
done

if ! command_exists rg; then
  echo "Installing ripgrep..."
  brew install ripgrep
else
  echo "ripgrep is already installed."
fi

# Post-install steps
if command_exists atuin && [$import_history = true ]; then
  atuin import auto
fi

echo ""
echo "✅ Setup complete. You're ready to code like a beast. 🦾"
[ "$import_history" = true ] && echo "→ Atuin history imported."
[ "$install_asdf" = true ] && echo "→ ASDF and Go plugin installed."
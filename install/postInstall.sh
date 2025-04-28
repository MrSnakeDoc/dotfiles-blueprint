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
      echo "Usage: $0 [-o] (o: install asdf plugins) [-a] (a: import history to atuin) [-h] (h: help)"
      exit 1;;
  esac
done

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install asdf plugins if requested
if ! command_exists asdf; then
  echo "Installing asdf plugins..."
  if ! asdf plugin list | grep -q golang; then
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
  fi
  asdf install golang latest
fi

# Post-install steps
if command_exists atuin && $import_history; then
  atuin import auto
fi

echo ""
echo "✅ Setup complete. You're ready to code like a beast. 🦾"
[ "$import_history" = true ] && echo "→ Atuin history imported."
# Dotfiles

This repository contains my personal dotfiles for setting up a consistent development environment across different machines.

## Overview

This repository provides a modular and maintainable way to manage terminal configurations, shell customizations, and development tools. It uses symbolic links to maintain configurations in a centralized location while allowing easy deployment across different environments.

## Structure

```
dotfiles/
├── .zsh/                   # ZSH configurations and modules
│   ├── .zsh_aliases        # All shell aliases
│   ├── .zsh_custom_config  # Custom ZSH settings
│   ├── .zsh_git_func       # Git-related functions
│   ├── .zsh_history        # History settings
│   ├── .zsh_keys           # Keyboard bindings
│   ├── .zsh_plugins        # Plugin configurations
│   └── .zsh_tools          # Development tools setup
├── .config/                # Application configurations
│   ├── starship.toml      # Starship prompt settings
│   └── kitty/             # Kitty terminal config
├── install/               # Installation scripts
│   ├── bootstrap.sh       # Base system setup
│   ├── brew.sh           # Install Homebrew packages
│   ├── symlinks.sh       # Symlink creation
│   ├── plugins           # Plugin installation (Go binary)
│   └── post_install.sh   # Additional configurations
```

## Features

- 🚀 **Fast and modular** ZSH configuration
- 🔄 **Auto-reload** of aliases when modified
- 🛠️ **Development tools** setup (Go, Python, Terraform, Docker)
- 🔌 **Plugin management** for ZSH
- ⚡ **CLI tools** for productivity (asdf, zoxide, fzf, atuin, bat, etc.)

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/MrSnakeDoc/dotfiles.git ~/dotfiles
```

2. Run the installation scripts:
```bash
cd ~/dotfiles/install
./bootstrap.sh    # Install required packages
./brew.sh        # Install Homebrew packages
./symlinks.sh    # Create symbolic links
./plugins        # Install and configure plugins
./post_install.sh # Additional configurations
```

> [!WARNING]  
> For detailed installation instructions, see the README in the `install/` directory.

Optional: Include Kitty terminal configuration:
```bash
./symlinks.sh -k
```

## Included Configurations

### Shell Environment
- **ZSH** with Starship prompt
- **Auto-suggestions** and syntax highlighting
- **Custom functions** for Git operations
- **Smart aliases** with auto-reload

### Development Tools
- **Git** configurations and aliases
- **Docker** shortcuts and utilities
- **Terraform** aliases
- **Python** environment setup
- **Golang** configuration with asdf
- **Ansible** workspace setup

### CLI Utilities
- **fzf** - Fuzzy finder
- **bat** - Modern cat replacement
- **eza** - Modern ls replacement
- **zoxide** - Smarter cd command
- **atuin** - Better shell history
- **ripgrep** - Fast search tool
- **btop** - Interactive process viewer
- **tldr** - help command for common tasks
- **asdf** - Version manager for multiple languages
- **lazygit** - Terminal UI for Git

## Customization

Modify your setup through:
- Individual files in `.zsh/`
- Tool-specific configs in `.config/`

## Requirements

- Git
- ZSH shell
- Homebrew (can be installed via the script `install/brew.sh`)
- Internet connection for package installation

## License

MIT License - Feel free to use and modify as needed!
# Installation Scripts

This directory contains scripts to set up your development environment. Follow the order below to properly configure your system.

## Quick Start

```bash
./bootstrap.sh  # Install required packages
./brew.sh      # Install Homebrew packages
./symlinks.sh   # Create dotfile symlinks
./plugins    # Install and configure plugins
./post_install.sh  # Additional configurations
```

## Scripts Overview

### 1. bootstrap.sh
**Purpose**: Installs essential packages and tools

**Requirements**: None

**Actions**:
- Install zsh

> [!WARNING]  
> Make sure to run this script first to set up your environment and restart your terminal or restart the virtual machine afterwards before running the other scripts.

### 2. brew.sh
**Purpose**: Installs Homebrew and packages

**Requirements**:
- bootstrap.sh completed
- curl installed

**Actions**:
- Installs Homebrew if needed
- Installs required packages

> [!WARNING]  
> Make sure to run this script first before the following scripts and restart your terminal or restart the virtual machine afterwards before running the other scripts.

### 3. symlinks.sh
**Purpose**: Creates symbolic links

**Requirements**: None

**Options**:
- `-k`: Include kitty terminal configuration

Example:
```bash
./symlinks.sh -k  # Create all symlinks including kitty config
```

### 4. plugins (binary file developed with golang)
**Purpose**: Configures development environment

**Requirements**: brew.sh completed

**Actions**:
- Installs zsh plugins
- Configures shell completions
- starship prompt
- other development tools
- other enhancements

Example:
```bash
./plugins -h  # to see all available options and learn how to use it
```


### 5. post_install.sh
**Purpose**: Finalizes setup

**Requirements**: plugins completed

**Actions**:
- Sets up golang with asdf
- Imports zsh history to atuin

## Requirements

- ZSH Shell
- Internet connection for package installation

## Troubleshooting

If you encounter any issues:
1. Make sure all scripts are executable (`chmod +x script.sh`)
3. Run scripts with `-x` flag for verbose output:
```bash
bash -x ./script.sh
```
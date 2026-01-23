#!/bin/bash

# Function to check if a line exists in run commands
line_exists_in_rc() {
  grep -Fxq "$1" ~/.bashrc
}

# Function to add line to run commands
add_to_rc() {
  if ! line_exists_in_rc "$1"; then
    echo "$1" >> ~/.bashrc
  fi
}

# Upgrade and install packages for Arch Linux (using pacman)
echo "=== Synchronize and Upgrade Packages ==="
# Synchronize repositories and upgrade the system
sudo pacman -Syu --noconfirm

# Install Ruby and necessary development tools
echo "=== Install Ruby and Base-devel ==="
# 'base-devel' includes essential tools like gcc, make, which are similar to build-essential
sudo pacman -S --noconfirm ruby base-devel

# Install Python 3 and pip
echo "=== Install Python ==="
# On Arch, 'python' is Python 3. 'python-pip' provides pip.
sudo pacman -S --noconfirm python python-pip

# Install Jupyter Notebook
echo "=== Install Jupyter Notebook ==="
# 'jupyter-notebook' is the package name on Arch
sudo pacman -S --noconfirm jupyter-notebook

#### GitHub Pages Local Build support
echo "=== GitHub pages build tools ==="
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
add_to_rc "# Ruby Gem Path"
add_to_rc 'export GEM_HOME="$HOME/gems"'
add_to_rc 'export PATH="$HOME/gems/bin:$PATH"'

echo "=== Gem install starting, thinking... ==="
gem install jekyll bundler

echo "=== !!!Start a new Terminal!!! ==="

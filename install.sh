#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  echo "🍎  macOS detected"
  echo ""
  
  set -eufo pipefail

  echo ""
  echo "🤚  This script will setup .dotfiles for you."
  read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

  # Install Homebrew
  command -v brew >/dev/null 2>&1 || \
    (echo '🍺  Installing Homebrew' && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")

  # Install chezmoi
  command -v chezmoi >/dev/null 2>&1 || \
    (echo '👊  Installing chezmoi' && brew install chezmoi)

  if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
    echo "🚸  chezmoi already initialized"
    echo "    Reinitialize with:"
    echo ""
    echo "chezmoi init eh8 --apply"
  else
    echo "🚀  Initializing dotfiles"
    chezmoi init eh8 --apply
  fi

  echo ""
  echo "✅  Done."
elif [ "$(uname)" == "Linux" ]; then
  # Install yay
  command -v yay >/dev/null 2>&1 || \
    (echo '📦  Installing Yay' && sudo pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si yay-bin)

  # Install chezmoi
  command -v chezmoi >/dev/null 2>&1 || \
    (echo '👊  Installing chezmoi' && yay -S chezmoi)

  if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
    echo "🚸  chezmoi already initialized"
    echo "    Reinitialize with:"
    echo ""
    echo "chezmoi init eh8 --apply"
  else
    echo "🚀  Initializing dotfiles"
    chezmoi init eh8 --apply
  fi

  echo ""
  echo "✅  Done."
fi


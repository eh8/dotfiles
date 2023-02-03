#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  echo "🍎  macOS detected"
  echo ""
  
  set -eufo pipefail

  echo ""
  echo "🤚  This script will setup .dotfiles for you."
  read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

  # Check sudo permissions available
  sudo -v
  
  # Install Homebrew
  command -v brew >/dev/null 2>&1 || \
    (echo '🍺  Installing Homebrew' && NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")

  if [ ! -f "/Users/$USER/.zprofile" ]; then
    echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> /Users/$USER/.zprofile
  fi

  eval $(/opt/homebrew/bin/brew shellenv)

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
  echo "🐧  Linux detected"
  echo ""
  
  echo ""
  echo "🤚  This script will setup .dotfiles for you."
  read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

  # Install yay
  command -v yay >/dev/null 2>&1 || \
    (echo '📦  Installing Yay' && sudo pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm yay-bin && yay -Y --gendb)

  # Install chezmoi
  command -v chezmoi >/dev/null 2>&1 || \
    (echo '👊  Installing chezmoi' && yay -S --noconfirm chezmoi)

  if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
    echo "🚸  chezmoi already initialized"
    echo "    Reinitialize with:"
    echo ""
    echo "chezmoi init eh8 --apply"
  else
    echo "🚀  Initializing dotfiles"
    chezmoi init eh8 --apply
  fi

  if ! echo $SHELL | grep -q zsh ; then
    echo "🐚  Changing default shell to zsh"
    chsh -s /usr/bin/zsh
    touch ~/.zsh_history
  fi

  echo ""
  echo "✅  Done."
fi

#!/bin/bash

set -eufo pipefail

echo ""
echo "🔧  Configuring macOS sudo to use Touch ID"
echo ""

# Check if this device is a Mac
if [[ "$(uname)" == "Darwin" ]]; then
  # Check if sudo-touchid already installed
  if ! [[ "$(head -n 2 '/etc/pam.d/sudo')" == *"pam_reattach.so"* ]]; then
    echo "❗  Touch ID not detected, fixing now ..."
    
    sudo brew services restart sudo-touchid
    sudo-touchid

    # Add pam_reattach module to use Touch ID in tmux
    backup_ext='.bak'
    touch_pam='auth       optional       \/opt\/homebrew\/lib\/pam\/pam_reattach.so'
    sudo_path='/etc/pam.d/sudo'
    nl=$'\n'

    sudo sed -E -i "$backup_ext" "1s/^(#.*)$/\1\\${nl}$touch_pam/" "$sudo_path"

    echo "✅  Done."
  else
    echo "✅  sudo-touchid already configured. Nothing to do."
  fi
else
  echo "❓  This script is intended to be run on a Mac only. Exiting now."
  exit 1
fi

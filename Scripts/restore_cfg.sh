#!/usr/bin/env bash
#|---/ /+--------------------------------+---/ /|#
#|--/ /-| Script to restore hyde configs |--/ /-|#
#|-/ /--| Prasanth Rangan                |-/ /--|#
#|/ /---+--------------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
  echo "Error: unable to source global_fn.sh..."
  exit 1
fi

ThemeOverride="${3:-}"

if pkg_installed git && pkg_installed stow; then
  git clone https://github.com/manangulati9/.dotfiles "$HOME/.dotfiles/"
  stow -d "$HOME"/.dotfiles -t "$HOME/" $(ls -d */)
else
  echo -e "\033[0;33m[SKIP]\033[0m dotfiles are already configured..."
fi

if [ -z "${ThemeOverride}" ]; then
  if nvidia_detect && [ $(grep '^source = ~/.config/hypr/nvidia.conf' "${HOME}/.config/hypr/hyprland.conf" | wc -l) -eq 0 ]; then
    echo -e 'source = ~/.config/hypr/nvidia.conf # auto sourced vars for nvidia\n' >>"${HOME}/.config/hypr/hyprland.conf"
  fi
fi

#!/usr/bin/env bash
set -e
export GITHUB_USER=${GITHUB_USER:-"Forestsoft-de"}
INSTALL_NEEDED=""
if [ ! -x "$(command -v git)" ]; then
  INSTALL_NEEDED="$INSTALL_NEEDED git"
fi
if [ ! -x "$(command -v sudo)" ]; then
  INSTALL_NEEDED="$INSTALL_NEEDED sudo"
fi
if [ ! -x "$(command -v jq)" ]; then
  INSTALL_NEEDED="$INSTALL_NEEDED jq"
fi
if [ ! -x "$(command -v curl)" ]; then
  INSTALL_NEEDED="$INSTALL_NEEDED curl"
fi

if [ "$INSTALL_NEEDED" != "" ]; then
  sudo apt update && sudo apt install -y $INSTALL_NEEDED
fi

if [ ! -x "$(command -v chezmoi)" ]; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply "$GITHUB_USER"
else
  if [ ! -d "$(chezmoi dump-config | jq -r '.sourceDir')" ]; then
     chezmoi init --apply  "$GITHUB_USER"
     chezmoi git config pull.rebase true
  fi
fi

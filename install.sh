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


if ! gpg --list-keys | grep -q 15696C5ECFA72ED0878336763BC542E629AF0562; then
mkdir -p ~/.exported_keys
chmod 700 ~/.exported_keys
cd ~/.exported_keys

# Notify the user to start inputting text
echo "Enter the private.gpg (Ctrl-D to stop):"

# Use a loop to read each line of text
while IFS= read -r line; do
    # Append each line to the file
    echo "$line" >> private.gpg
done
gpg --import private.gpg

cd ~/
rm -Rf ~/.exported_keys
fi
if [ ! -x "$(command -v chezmoi)" ]; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply "$GITHUB_USER"
else
  if [ ! -d "$(chezmoi dump-config | jq -r '.sourceDir')" ]; then
     chezmoi init --apply  "$GITHUB_USER"
     chezmoi git config pull.rebase true
  fi
fi

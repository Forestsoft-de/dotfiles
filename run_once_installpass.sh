#!/bin/bash
set -e

if [ "$HOME" == "" ]; then
  echo "HOME is not defined could not install password store"
  exit 255
fi

if [ -d  "$HOME/.password-store" ];
  echo "Skip password install. Directory already exist"
  exit 0
fi

if [ "$GITHUB_PAT" == "" ]; then
  echo "Please define GITHUB_PAT for https://Forestsoft-de:<PAT>@github.com/Forestsoft-de/password-store.git"
  exit 255
fi
cd $HOME
git clone https://Forestsoft-de:${GITHUB_PAT}@github.com/Forestsoft-de/password-store.git $HOME/.password-store
cd $HOME/.password-store
./install.sh

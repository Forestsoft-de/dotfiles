#!/bin/bash
set -e
if [ "$HOME" == "" ]; then
  echo "HOME is not defined could not install password store"
  exit 255
fi

if [ -d  "$HOME/.password-store" ]; then
  echo "Skip password install. Directory already exist"
  exit 0
fi

export GITHUB_PAT=${GITHUB_PAT:-$(chezmoi dump-config | jq -r '.data.github_pat')}
export GITHUB_USER=${GITHUB_USER:-$(chezmoi dump-config | jq -r '.data.github_account')}

if [ "$GITHUB_PAT" == "" ]; then
  echo "Please define GITHUB_PAT for https://Forestsoft-de:<PAT>@github.com/Forestsoft-de/password-store.git"
  exit 255
fi
cd $HOME
git clone https://${GITHUB_USER}:${GITHUB_PAT}@github.com/${GITHUB_USER}/password-store.git $HOME/.password-store
cd $HOME/.password-store
./install.sh

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
  mkdir -p ${HOME}/.ssh
  pass ssh/dinkel > ${HOME}/.ssh/id_rsa
  chmod 400 ${HOME}/.ssh/id_rsa
fi

if [ ! -f "$HOME/.kube/forestsoft/config" ]; then
  mkdir -p ${HOME}/.kube/forestsoft/
  pass kubeconfigs/rke-forestsoft > ${HOME}/.kube/forestsoft/config
  chmod 400 ${HOME}/.kube/forestsoft/config
fi

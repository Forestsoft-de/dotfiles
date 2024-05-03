#!/usr/bin/env bash
export GITHUB_USERNAME=${GITHUB_USERNAME:-"Forestsoft-de"}
if [ ! -x $(command -v "chezmoi") ]; then
	sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
fi

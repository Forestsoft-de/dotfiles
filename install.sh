#!/usr/bin/env bash

sudo apt update && sudo apt install -y curl nano rsync

curl -sS https://starship.rs/install.sh | sh

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh . ~;
	source ~/.bash_profile;
}

if sh -c ": >/dev/tty" >/dev/null 2>/dev/null; then
   if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
   else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
  fi;
else
   doIt # /dev/tty is not available
fi


unset doIt;
#!/usr/bin/env bash

if [ "$HOME" == "" ]; then
  echo "Could not install dotfiles. Homedir is not recognized"
  exit 2
fi

sudo apt update && sudo apt install -y curl nano rsync

if [ ! -d $HOME/.fonts/ ]; then
  mkdir -p $HOME/.fonts/
  cd $HOME/.fonts/
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip
  rm JetBrainsMono.zip
fi



if [ ! -x starship ]; then
  mkdir -p $HOME/bin/
  curl -sS https://starship.rs/install.sh | sh -s  -- --force --bin-dir $HOME/bin/
fi

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh -O . $HOME;
	source $HOME/.bash_profile;
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

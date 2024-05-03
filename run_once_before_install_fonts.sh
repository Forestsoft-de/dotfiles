#!/bin/bash

if [ -x "$(command -v starship)" ] && [ ! -d $HOME/.fonts/ ]; then
  mkdir -p $HOME/.fonts/
  cd $HOME/.fonts/
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip
  rm JetBrainsMono.zip
fi

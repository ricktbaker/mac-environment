#!/usr/bin/env bash

# General settings for all environments
if [ ! -d "~/.tool-versions" ]; then
  ln -s ~/Work/general/mac-environment/dotfiles/global/.tool-versions ~/.tool-versions
fi
if [ ! -d "~/.p10k.zsh" ]; then
  ln -s ~/Work/general/mac-environment/dotfiles/global/p10k.zsh ~/.p10k.zsh 
fi
if [ ! -d "~/.zshrc" ]; then
  ln -s ~/Work/general/mac-environment/dotfiles/global/zshrc ~/.zshrc 
fi

COMPUTER_NAME=$(scutil --get ComputerName)
if [[ $COMPUTER_NAME -eq "forta" ]]; then
  echo "Setting up Forta environment"
elif [[ $COMPUTER_NAME -eq "LOXC02G80QPMD6Q" ]]; then
  echo "Setting up Assurant environment"
elif [[ $COMPUTER_NAME -eq "syneos" ]]; then
  echo "Setting up Syneos environment"
fi

# Install asdf versions
cd ~/ && asdf install



#!/usr/bin/env bash

# General settings for all environments
ln -s ~/.p10k.zsh ~/Work/general/mac-environment/dotfiles/global/p10k.zsh
ln -s ~/.oh-my-zsh-custom ~/Work/general/mac-environment/dotfiles/global/oh-my-zsh-custom
ln -s ~/.zshrc ~/Work/general/mac-environment/dotfiles/global/zshrc

COMPUTER_NAME=$(scutil --get ComputerName)
if [[ $COMPUTER_NAME -eq "forta" ]]; then
  echo "Setting up Forta environment"
elif [[ $COMPUTER_NAME -eq "LOXC02G80QPMD6Q"]]; then
  echo "Setting up Assurant environment"
elif [[ $COMPUTER_NAME eq "syneos" ]]; then
  echo "Setting up Syneos environment"
fi



#!/usr/bin/env bash

#######################################################################################
# XCODE
#######################################################################################
echo "Installing xcode-stuff"
xcode-select --install

#######################################################################################
# Oh-My-ZSH
#######################################################################################
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

#######################################################################################
# Oh-My-ZSH theme and fonts
#######################################################################################
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

fonts_list=(
  font-meslo-lg-nerd-font
)

brew tap homebrew/cask-fonts

for font in "${fonts_list[@]}"
do
  brew install --cask "$font"
done

#######################################################################################
# Homebrew
#######################################################################################
# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

#######################################################################################
# Homebrew Formulas
#######################################################################################
forumulas=(
  asdf
  gh
  git
)

# Install forumulas
echo "installing brew formulas.."
brew install ${forumulas[@]}

echo "Cleaning up brew"
brew cleanup

#######################################################################################
# Homebrew Cask Apps
#######################################################################################
apps=(
  brave-browser
  docker
  microsoft-teams
  slack
  visual-studio-code
  zoom
)

echo "installing brew apps with Cask..."
brew install --appdir="/Applications" --cask ${apps[@]}

brew cleanup

#######################################################################################
# Git Config
#######################################################################################
echo "Git config"

git config --global user.name "Rick Baker"
git config --global user.email "rick.todd.baker@gmail.com"

#######################################################################################
# The rest of the setup including dotfiles
#######################################################################################
mkdir -p ~/Work/general
if [ ! -d "~/Work/general/mac-environment" ]; then
  git clone https://github.com/ricktbaker/mac-environment.git
fi
git pull


#######################################################################################
# Basic Mac Setup
#######################################################################################
echo "Setting some Mac settings..."

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

#"Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Disable 'natural' (Lion-style) scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

killall Finder

echo "Done!"
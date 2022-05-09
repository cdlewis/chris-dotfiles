#!/bin/bash

set -euxo pipefail

# Set up homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew analytics off

# Languages
brew install \
	go \
	node

# Utilities
brew install \
	terminal-notifier \ # Needed for notifications scripts
	jq \
	vim \
	Maccy \ # Clipboard helper
	gs \ # ghost script
	mas # mac app store cli
go get github.com/cdlewis/git-switch
xcode-select --install

# Mac App Store
mas install 937984704 # Amphetamine 'keep awake' app

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Stretchly fork
git clone git@github.com:cdlewis/stretchly.git
cd stretchly
npm run dist

# Set new screenshots directory to avoid cluttering desktop
mkdir ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

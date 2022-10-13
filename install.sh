#!/bin/bash

set -euxo pipefail

if ! xcode-select -p; then
	xcode-select --install
fi

# Set up homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

# Languages
brew install \
	go \
	node

# Utilities
brew install \
	terminal-notifier \
	jq \
	vim \
	Maccy \
	gs \
	mas

# Mac App Store
mas install 937984704 # Amphetamine 'keep awake' app

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set new screenshots directory to avoid cluttering desktop
mkdir ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

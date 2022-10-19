#!/bin/bash

set -euxo pipefail

if ! xcode-select -p; then
	xcode-select --install
fi

# Set up homebrew
if ! which brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew analytics off
fi

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
mas install 1091189122 # Bear – Markdown Notes
mas install 1351639930 # Gifski

# Oh My Zsh
if [ ! -d ~/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Set new screenshots directory to avoid cluttering desktop
mkdir ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

#!/bin/bash

set -euxo pipefail

if ! xcode-select -p; then
	xcode-select --install
fi

softwareupdate --install-rosetta

# Set up homebrew
if ! which brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
	brew analytics off
fi

# Languages
brew install go
brew install node
brew install coursier/formulas/coursier
cs setup

# Utilities
brew install \
	terminal-notifier \
	jq \
	vim \
	gs \
	mas \
	Maccy \
	difftastic

# Warp terminal (https://www.warp.dev/)
brew install --cask warp

# Mac App Store
mas install 937984704 # Amphetamine 'keep awake' app
mas install 1091189122 # Bear – Markdown Notes
mas install 1351639930 # Gifski
mas install 803453959 # Slack

# Oh My Zsh
if [ ! -d ~/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Set new screenshots directory to avoid cluttering desktop
mkdir ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

# Update zshrc
(echo "source $(pwd)/zshrc") >> ~/.zshrc
source ~/.zshrc

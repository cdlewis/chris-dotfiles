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
	terminal-notifier \
	jq \
	vim
go get github.com/cdlewis/git-switch
xcode-select --install

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Stretchly fork
git clone git@github.com:cdlewis/stretchly.git
cd stretchly
npm run dist

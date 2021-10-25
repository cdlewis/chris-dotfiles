# ZSH Configuration
ZSH_POWERLINE_SINGLE_LINE="true"
ZSH_POWERLINE_SHOW_USER="false"
ZSH_POWERLINE_SHOW_IP="false"
ZSH_POWERLINE_SHOW_GIT_STATUS="false"
ZSH_POWERLINE_SHOW_GIT_BRAHCH_ONLY="true"
ZSH_POWERLINE_SHOW_OS="false"
ZSH_THEME="solarized-powerline"

# Git Shortcuts
alias gst="git status"
alias gb="git branch"
alias gsb="git-switch"
alias gs="git status -uno"

# Arc Quality of Life
EDITOR=vim
alias yeet="arc diff --add-all --message \"code review feedback\""

# Pants Quality of Life
alias nuke-pants="PANTS_CONCURRENT=True ~/workspace/source/pants clean-all && ~/workspace/source/pants ng-killall && ~/workspace/source/pants kill-pantsd"
alias yeet-pants="PANTS_CONCURRENT=True ~/workspace/source/pants ng-killall && ~/workspace/source/pants kill-pantsd"

# Kill any application listening on a given port
killport() {
  lsof -nti:$1 | xargs kill -9
}

# Sensible PDF image compression
compressPdf () {
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dCompatibilityLevel=1.7 -dNOPAUSE -dQUIET -dPDFSETTINGS=/prepress -sOutputFile="$1_compressed.pdf" "$1"
}

# ZSH Configuration
ZSH_POWERLINE_SINGLE_LINE="true"
ZSH_POWERLINE_SHOW_USER="false"
ZSH_POWERLINE_SHOW_IP="false"
ZSH_POWERLINE_SHOW_GIT_STATUS="false"
ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY="true"
ZSH_POWERLINE_SHOW_OS="false"
ZSH_THEME="solarized-powerline"
DISABLE_UPDATE_PROMPT=true

# Git Shortcuts
alias gst="git status"
alias gb="git for-each-ref --sort=committerdate refs/heads --format='%(color:red)%(authordate:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset)) %(contents:lines=1)'"
alias gsb="git-switch"
alias gs="git status -uno"
alias rebase="git fetch && git rebase origin/master"

# Arc Quality of Life
EDITOR=vim
alias yeet="arc diff --add-all --message \"We made improvements and squashed bugs so this diff is even better for you.\""

# Kill any application listening on a given port
killport() {
  lsof -nti:$1 | xargs kill -9
}

# Allow sudo to expand aliases by making sudo itself an alias
alias sudo='sudo '

# When pre-installed trash decides to eat up every CPU core
chill() {
  TARGET=$1
  while true; do
    PROCESS_TO_CHILL=$(ps -ax | grep -m 1 $TARGET | awk '{print $1}')
    echo "Telling $TARGET($PROCESS_TO_CHILL) to chill for a sec"
    kill $PROCESS_TO_CHILL
    sleep 3
  done
}

precmd() {
  if [[ "$(($RANDOM % 10))" -gt "8" ]]; then echo "🥰 ps i love u 🥰"; fi;
}

# Sensible PDF image compression
compressPdf () {
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dCompatibilityLevel=1.7 -dNOPAUSE -dQUIET -dPDFSETTINGS=/prepress -sOutputFile="$1_compressed.pdf" "$1"
}

# Nobody asked for you to send me an HEIC
convertHeic () {
  mkdir -p Converted
  for i in *.HEIC; do sips -s format jpeg $i --out Converted/$i.jpeg; done
}

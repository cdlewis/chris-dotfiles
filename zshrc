# ZSH Configuration
ZSH_POWERLINE_SINGLE_LINE="true"
ZSH_POWERLINE_SHOW_USER="false"
ZSH_POWERLINE_SHOW_IP="false"
ZSH_POWERLINE_SHOW_GIT_STATUS="false"
ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY="true"
ZSH_POWERLINE_SHOW_OS="false"
ZSH_THEME="solarized-powerline"
DISABLE_UPDATE_PROMPT=true
CELLAR="$(brew --cellar)"
GHOSTSCRIPT="$(find $CELLAR -name gs | head -n 1)"

# Inherit configurations from remote shell
source zsh_remote_shell

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
  $GHOSTSCRIPT -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dCompatibilityLevel=1.7 -dNOPAUSE -dQUIET -dPDFSETTINGS=/prepress -sOutputFile="$1_compressed.pdf" "$1"
}

# Nobody asked for you to send me an HEIC
convertHeic () {
  mkdir -p Converted
  for i in *.HEIC; do sips -s format jpeg $i --out Converted/$i.jpeg; done
}

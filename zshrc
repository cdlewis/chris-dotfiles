# ZSH Configuration
ZSH_POWERLINE_SINGLE_LINE="true"
ZSH_POWERLINE_SHOW_USER="false"
ZSH_POWERLINE_SHOW_IP="false"
ZSH_POWERLINE_SHOW_GIT_STATUS="false"
ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY="true"
ZSH_POWERLINE_SHOW_OS="false"
ZSH_THEME="solarized-powerline"

# Git Shortcuts
alias gst="git status"
alias gb="git branch"
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

# Notify user when a long running command finishes (> 15 seconds)
preexec() {
  command_start_time=$SECONDS
  command_summary="$2"
}
precmd() {
  if [ -n "$command_start_time" ]; then
    execution_time=$(($SECONDS - $command_start_time))

    # Some commands are uninteresting (e.g. editting a file)
    ignore_list="^(vim)"

    if [ $execution_time -gt 14 ] && [[ ! $command_summary =~ $ignore_list  ]]; then
      ( \
        terminal-notifier \
          -title "Long running command finished" \
	  -subtitle "Duration: $execution_time seconds" \
          -message "$command_summary" \
        &> /dev/null & \
      )

      echo "$command_summary" | rotatelogs -t ~/long_running_commands.log 100M
    fi;
  fi;

  # `precmd` can be triggered without a `preexec`. Unset to avoid
  # spamming notifications.
  command_start_time=""
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

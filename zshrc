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
alias rebase="git fetch && git rebase origin/master"

# Arc Quality of Life
EDITOR=vim
alias yeet="arc diff --add-all --message \"We made improvements and squashed bugs so this diff is even better for you.\""

# Pants Quality of Life
alias nuke-pants="PANTS_CONCURRENT=True ~/workspace/source/pants clean-all && ~/workspace/source/pants ng-killall && ~/workspace/source/pants kill-pantsd"
alias yeet-pants="PANTS_CONCURRENT=True ~/workspace/source/pants ng-killall && ~/workspace/source/pants kill-pantsd"

# Kill any application listening on a given port
killport() {
  lsof -nti:$1 | xargs kill -9
}

# Pulse VPN is trash
killvpn() {
  sudo launchctl unload /Library/LaunchDaemons/net.pulsesecure.AccessService.plist && sudo launchctl load /Library/LaunchDaemons/net.pulsesecure.AccessService.plist
}

# CrashPlan is trash
killcrashplan() {
  CRASHPLAN_PROCESS=$(ps -ax | grep -m 1 CrashPlanService.app | awk '{print $1}')
  echo "Adjusting crashplan priority $CRASHPLAN_PROCESS"
  sudo renice 20 $CRASHPLAN_PROCESS
  CODE42_PROCESS=$(ps -ax | grep -m 1 Code42Service.app | awk '{print $1}')
  echo "Adjusting code42 priority $CODE42_PROCESS"
  sudo renice 20 $CODE42_PROCESS
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

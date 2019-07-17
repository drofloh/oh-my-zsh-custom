###############################################################
# drofloh oh-my-zsh theme
# https://github.com/drofloh/oh-my-zsh-custom
################################################################

function prompt_separator() {
  echo ''
}

function rprompt_separator() {
  echo ''
}

function prompt_start() {
  local bg_col=%{$BG[236]%}
  
  local ret_status="%(?:%{$fg[green]%}  :%{$fg[red]%}  )${reset_color}"
  echo "${bg_col}${ret_status}"
}

function prompt_dir() {
  local bg_col=%{$BG[240]%}
  local fg_col=%{$FG[236]%}
  local dir_icon="%{$fg[blue]%}   "
  local directory="%{$fg[white]%}%~"

  echo "${bg_col}${fg_col}$(prompt_separator)${dir_icon}${directory}"
}

function prompt_git () {

  local bg_col=$BG[244]
  local fg_col=$FG[240]

  local prompt_git_start="%{$fg_col%}$(prompt_separator)"
  local prompt_git_end="%{$reset_color%}%{$FG[244]%}$(prompt_separator)"
  # https://stackoverflow.com/questions/2180270/check-if-current-directory-is-a-git-repository
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    echo "%{$bg_col%}${prompt_git_start} %{$fg[blue]%} $(parse_git_dirty) %{$fg[white]%}$(git_current_branch) $(git_prompt_status) $(git_remote_status)$(git_prompt_behind)$(git_prompt_ahead)$(git_prompt_remote)${prompt_git_end}"
  else
    echo "%{$reset_color%}%{$prompt_git_start%}"
  fi
}

function prompt_battery() {

  battery_perc=$(battery_pct)
  if [ $battery_perc -gt 90 ]; then
    icon=''
    batt_col=$fg[green]
  elif [ $battery_perc -gt 70 ]; then
    icon=''
    batt_col=$fg[green]
  elif [ $battery_perc -gt 50 ]; then
    icon=''
    batt_col=$fg[green]
  elif [ $battery_perc -gt 30 ]; then
    icon=''
    batt_col=$fg[yellow]
  elif [ $battery_perc -gt 10 ]; then
    icon=''
    batt_col=$fg[yellow]
  else
    icon=''
    batt_col=$fg[red]
  fi

  if $(battery_is_charging) ; then
    power_icon="%{$fg[yellow]%}"
  elif $(plugged_in) ; then
    power_icon=''
    icon=''
    batt_col=$fg[green]
  fi
  echo "%{$FG[240]%}$(rprompt_separator) %{$BG[240]%} %{$batt_col%}${icon}${power_icon} %{$fg[white]%}${battery_perc}%%%{$reset_color%}"
}

function prompt_time() {
  local time_icon="%{$fg[magenta]%}"
  local the_time="%{$fg[white]%}[%T]"

  echo "%{$FG[244]%}$(rprompt_separator) %{$BG[244]%} ${time_icon} ${the_time}"
}

###############################################################
# drofloh oh-my-zsh theme functions
# https://github.com/drofloh/oh-my-zsh-custom
################################################################

typeset -AHg ICONS

ICONS=(
  # Prompt separators
  flame_right        $'\ue0c0' # 
  flame_left         $'\ue0c2' # 
  terminal           $'\uf120' # 

  # OS logos
  apple_logo         $'\uf302' # 

  # directory icon
  folder             $'\ufc6e' # ﱮ

  # battery usage
  battery_full       $'\uf578' # 
  battery_80         $'\uf580' # 
  battery_60         $'\uf57e' # 
  battery_40         $'\uf57c' # 
  battery_20         $'\uf57a' # 
  battery_empty      $'\uf58d' # 
  battery_charging   $'\uf0e7' # 
  battery_plugged_in $'\uf583' # 

  # time / clock icon
  time               $'\uf49b' # 

  # ruby icon
  ruby               $'\ue21e' #  

  # git status icons
  git_branch         $'\ue0a0' # 
  git_added          $'\uf457' # 
  git_modified       $'\uf459' # 
  git_deleted        $'\uf458' # 
  git_renamed        $'\uf45a' # 
  git_unmerged       $'\ue727' # 
  git_untracked      $'\uf128' # 
  git_ahead          $'\uf061' # 
  git_behind         $'\uf060' # 
  git_remote_exists  $'\ufadf' # 﫟
  git_remote_missing $'\uf658' # 
)

function prompt_separator() {
  echo $ICONS[flame_right]
}

function rprompt_separator() {
  echo $ICONS[flame_left]
}

function prompt_start() {
  local bg_col=%{$BG[236]%}
  
  local ret_status="%(?:%{$fg[green]%} $ICONS[apple_logo] :%{$fg[red]%} $ICONS[apple_logo] )${reset_color}"
  echo "${bg_col}${ret_status}"
}

function prompt_dir() {
  local bg_col=%{$BG[240]%}
  local fg_col=%{$FG[236]%}
  local dir_icon="%{$fg[blue]%}  $ICONS[folder] "
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
    echo "%{$bg_col%}${prompt_git_start} %{$fg[blue]%} $(parse_git_dirty) %{$fg[white]%}$(git_current_branch)$(git_prompt_status)$(git_remote_status)$(git_prompt_remote)${prompt_git_end}"
  else
    echo "%{$reset_color%}%{$prompt_git_start%}"
  fi
}

function prompt_battery() {
  if [[ "$OSTYPE" = darwin* ]]; then
    battery_perc=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
  else
    battery_perc=$(battery_pct)
  fi

  if [[ $battery_perc -gt 90 ]]; then
    icon=$ICONS[battery_full]
    batt_col=$fg[green]
  elif [[ $battery_perc -gt 70 ]]; then
    icon=$ICONS[battery_80]
    batt_col=$fg[green]
  elif [[ $battery_perc -gt 50 ]]; then
    icon=$ICONS[battery_60]
    batt_col=$fg[green]
  elif [[ $battery_perc -gt 30 ]]; then
    icon=$ICONS[battery_40]
    batt_col=$fg[yellow]
  elif [[ $battery_perc -gt 10 ]]; then
    icon=$ICONS[battery_20]
    batt_col=$fg[yellow]
  else
    icon=$ICONS[battery_empty]
    batt_col=$fg[red]
  fi

  if $(battery_is_charging) ; then
    power_icon="%{$fg[yellow]%}${ICONS[battery_charging]}"
  elif $(plugged_in) ; then
    power_icon=''
    icon=$ICONS[battery_plugged_in]
    batt_col=$fg[green]
  fi
  echo "%{$FG[240]%}$(rprompt_separator) %{$BG[240]%} %{$batt_col%}${icon}${power_icon} %{$fg[white]%}${battery_perc}%% %{$reset_color%}"
}

function prompt_time() {
  local time_icon="%{$fg[cyan]%}${ICONS[time]}"
  local the_time="%{$fg[white]%}[%T]"

  echo "%{$FG[244]%}$(rprompt_separator) %{$BG[244]%} ${time_icon} ${the_time}"
}

function prompt_ruby_rbenv() {
  local ruby_icon="%{$fg[red]%}${ICONS[ruby]}"
  if [ -f .ruby-version ] ; then
    local version="%{$fg[white]%}$(cat .ruby-version)"
    echo "%{$FG[248]%}$(rprompt_separator) %{$BG[248]%} ${ruby_icon} ${version}"
  fi
}

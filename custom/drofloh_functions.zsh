###############################################################
# drofloh oh-my-zsh theme functions
# https://github.com/drofloh/oh-my-zsh-custom
################################################################

typeset -AHg ICONS

ICONS=(
  # Prompt separators
  flame_right        $'\ue0c0' # 
  divider_right      $'\ue0b0' # 
  flame_left         $'\ue0c2' # 
  divider_left       $'\ue0b2' # 
  terminal           $'\uf120' # 

  # OS logos
  apple_logo         $'\uf302' # 

  # directory icon
  folder             $'\ufc6e' # ﱮ


  # node icon
  node               $'\ue719' # 

  # git status icons
  git_branch         $'\ue0a0' # 
  git_added          $'\uf457' # 
  git_modified       $'\ufbf0' # ﯰ
  git_deleted        $'\ufbf0' # ﯰ
  git_renamed        $'\uf45a' # 
  git_unmerged       $'\ue727' # 
  git_untracked      $'\uf128' # 
  git_ahead          $'\uf061' # 
  git_behind         $'\uf060' # 
  git_remote_exists  $'\uf662' # 
  git_remote_missing $'\uf663' # 
)

function prompt_flame_separator() {
  echo $ICONS[flame_right]
}

function prompt_divider_separator() {
  echo $ICONS[divider_right]
}

function rprompt_flame_separator() {
  echo $ICONS[flame_left]
}

function rprompt_divider_separator() {
  echo $ICONS[divider_left]
}

function prompt_start() {
  # TODO - change bg_col, fg[green] and fg[red]
  local bg_col=%{$BG[236]%}
  
  local ret_status="%(?:%{$fg[green]%} $ICONS[terminal] :%{$fg[red]%} $ICONS[terminal] )${reset_color}"
  echo "${bg_col}${ret_status}"
}

function prompt_dir() {
  # TODO - change bg_col, fg_col, fg[white]
  local bg_col=%{$BG[240]%}
  local fg_col=%{$FG[236]%}
  local directory=" %{$fg[white]%}%c "

  echo "${bg_col}${fg_col}$(prompt_divider_separator)${directory}"
}

function prompt_nvm() {
  # TODO - Colors
  local nvm_prompt
  if type nvm >/dev/null 2>&1; then
    nvm_prompt=$(nvm current 2>/dev/null)
    [[ "${nvm_prompt}x" == "x" || "${nvm_prompt}" == "system" ]] && return
  elif type node >/dev/null 2>&1; then
    nvm_prompt="$(node --version)"
  else
    return
  fi
  nvm_prompt=${nvm_prompt}

  local bg_col=%{$BG[240]%}
  local fg_col=%{$FG[236]%}
  local nvm=" %{$fg[white]%}$ICONS[node] ${nvm_prompt} "
  echo "$(rprompt_divider_separator)${bg_col}${nvm}${fg_col}$(rprompt_divider_separator)"
}

function prompt_git () {

  # TODO - colors

  local bg_col=$BG[244]
  local fg_col=$FG[240]

  local prompt_git_start="%{$fg_col%}$(prompt_divider_separator)"
  local prompt_git_end=" %{$reset_color%}%{$FG[244]%}$(prompt_flame_separator)"
  # https://stackoverflow.com/questions/2180270/check-if-current-directory-is-a-git-repository
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    echo "%{$bg_col%}${prompt_git_start} %{$fg[blue]%} $(parse_git_dirty) %{$fg[white]%}$(git_current_branch)$(git_prompt_status)$(git_remote_status)$(git_prompt_remote)${prompt_git_end}"
  else
    echo "%{$reset_color%}%{$prompt_git_start%}"
  fi
}


###############################################################
# drofloh oh-my-zsh theme
# https://github.com/drofloh/oh-my-zsh-custom
#
# A personal oh-my-zsh theme for use with MacOS / iTerm
# 
# Requires a patched font with extra glyphs / icons, one can be
# obtained from nerd-fonts:
#     https://github.com/ryanoasis/nerd-fonts
# Tested with Hack: 
#     https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack
#
# Should also enable the battery plugin in the main oh-my-zsh 
# ~/.zshrc
#
#                                          
################################################################

PROMPT='$(prompt_start)$(prompt_dir)$(prompt_git)
%{$fg[white]%} $ '

RPROMPT='$(prompt_time)$(prompt_battery)'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[magenta]%}"

# Add rbenv to PATH and setup if command exists
if [ -x "$(command -v rbenv)" ]; then
  export PATH="${HOME}/.rbenv/shims:${PATH}"
  export RBENV_SHELL=zsh
  source '/opt/homebrew/Cellar/rbenv/1.2.0/completions/rbenv.zsh'
  command rbenv rehash 2>/dev/null
  rbenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    rehash|shell)
      eval "$(rbenv "sh-$command" "$@")";;
    *)
      command rbenv "$command" "$@";;
    esac
  }
fi

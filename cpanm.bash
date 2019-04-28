cpan-module() {
  command -v cpanm >/dev/null || {
    hint "Can't find cpanm home directory. Set PERL_CPANM_HOME."
    return 0
  }

  modules=$COMPLETE_SHELL_CACHE/cpanm
  [[ -f $modules ]] || {
    hint "Can't find CPAN modules cache file: '$modules'."
    hint "Try 'complete-shell install cpanm'."
    return 0
  }

  local cur prev words cword
  _init_completion -n : || return 0
  echo "$ comp_word='$cur'"

  if command -v fzf >/dev/null; then
    ( grep "^$cur" < "$modules" ) |
      fzf --multi --layout=reverse |
      xargs

  else
    ( grep "^$cur" < "$modules" ) |
      head -n2000
  fi
}

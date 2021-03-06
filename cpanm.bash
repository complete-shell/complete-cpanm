# shellcheck shell=bash disable=2034

cpan-module() {
  modules=$COMPLETE_SHELL_CACHE/cpanm
  [[ -f $modules ]] || {
    hint "Can't find CPAN modules cache file: '$modules'."
    hint "Try 'complete-shell install cpanm'."
    return 0
  }

  local fzf_options=(
    '--layout=reverse'
    '--multi'
    '--height=0'
    '--color=bw'
    '--bind=space:toggle-down,ctrl-space:up+toggle,del:deselect-all+top'
  )

  (echo; cat "$modules") | complete-shell-pager
}

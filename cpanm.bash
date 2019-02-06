cpan-module() {
  dir=${PERL_CPANM_HOME:-$HOME/.cpanm}

  [[ -d $dir ]] || {
    hint "Can't find cpanm home directory. Set PERL_CPANM_HOME."
    return 0
  }

  dir=${dir%/}/sources
  [[ -d $dir ]] || {
    hint "No directory '$dir/'. Try 'cpanm --mirror-only http://cpan.cpantesters.org/ Acme'."
    return 0
  }

  packages=$(find $dir -name 02packages.details.txt)
  [[ $packages ]] || {
    hint "Can't find '02packages.details.txt' in '$dir'. Try 'cpanm --mirror-only http://cpan.cpantesters.org/ Acme'."
    return 0
  }

  local cur prev words cword
  _init_completion -n : || return 0
  echo "$ comp_word='$cur'"

  tail -n+10 "$packages" | cut -d' ' -f1 | grep "^$cur" | head -n2000
}

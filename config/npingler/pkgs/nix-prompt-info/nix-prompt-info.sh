if [ -n "${NIX_SHELL_LEVEL:-}" ]; then
  direnv_status="$(direnv status --json | jq --raw-output '.state.loadedRC.allowed')"
  if [ "${direnv_status:-}" = "0" ]; then
    output="direnv"
  elif [ -n "${name:-}" ]; then
    output="$name"
  else
    output="${IN_NIX_SHELL:-unknown}"
  fi

  if [ "$NIX_SHELL_LEVEL" -gt 1 ]; then
    shlvl_str=":$NIX_SHELL_LEVEL"
  else
    shlvl_str=""
  fi

  printf "[%s]" "${output}${shlvl_str}"
fi

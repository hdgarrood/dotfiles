# shellcheck shell=bash

if [ "${IN_NIX_SHELL:-}" != "" ] || [ "${IN_NIX_RUN:-}" != "" ]; then
  # We need to subtract one from SHLVL for this script itself
  effective_shlvl=$((SHLVL - 1))
  if [ "$effective_shlvl" -gt 2 ]; then
    shlvl_str=":$effective_shlvl"
  else
    shlvl_str=""
  fi

  if [ -n "${DIRENV_FILE:-}" ]; then
    output="direnv"
  elif [ "${name:-}" == "shell" ]; then
    output="$IN_NIX_SHELL"
  elif [ -n "${name:-}" ]; then
    output="name"
  fi

  printf "[%s]" "${output}${shlvl_str}"
fi

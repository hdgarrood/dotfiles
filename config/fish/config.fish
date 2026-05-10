if status --is-interactive
  fish_vi_key_bindings

  if command -v buck2 >/dev/null
    buck2 completion fish | source
  end
end

if command -v nix-your-shell >/dev/null
  nix-your-shell fish | source
end

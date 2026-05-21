{
  direnv,
  jq,
  writeShellApplication,
}:
writeShellApplication {
  name = "nix-prompt-info";

  runtimeInputs = [
    direnv
    jq
  ];

  text = builtins.readFile ./nix-prompt-info.sh;
}

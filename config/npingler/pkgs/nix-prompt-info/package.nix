{
  writeShellApplication,
}:
writeShellApplication {
  name = "nix-prompt-info";

  text = builtins.readFile ./nix-prompt-info.sh;
}

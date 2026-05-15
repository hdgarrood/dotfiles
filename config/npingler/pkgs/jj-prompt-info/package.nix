{
  jujutsu,
  writeShellApplication,
}:
writeShellApplication {
  name = "jj-prompt-info";

  runtimeInputs = [ jujutsu ];

  text = builtins.readFile ./jj-prompt-info.sh;
}

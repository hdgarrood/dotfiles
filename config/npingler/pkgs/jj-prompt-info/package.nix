{
  git,
  jujutsu,
  writeShellApplication,
}:
writeShellApplication {
  name = "jj-prompt-info";

  runtimeInputs = [ git jujutsu ];

  text = builtins.readFile ./jj-prompt-info.sh;
}

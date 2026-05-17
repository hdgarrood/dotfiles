{
  writeShellApplication,
}:
writeShellApplication {
  name = "harry-notify";

  runtimeInputs = [ ];

  text = builtins.readFile ./harry-notify.sh;
}

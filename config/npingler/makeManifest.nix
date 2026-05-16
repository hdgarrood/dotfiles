# Create a manifest.json given a list of paths which will form your profile.
{
  lib,
  writeTextFile,
}:
{ paths }:
let
  manifestAttrs = lib.listToAttrs (
    builtins.map (p: {
      name = p.pname or p.name;
      value = {
        version = builtins.toString p.version or "0";
        storePath = builtins.toString p;
      };
    }) paths
  );

in
writeTextFile {
  name = "npingler-manifest";
  text = builtins.toJSON manifestAttrs;
  destination = "/share/npingler/manifest.json";
}

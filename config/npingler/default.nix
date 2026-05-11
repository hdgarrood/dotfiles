let
  npins-sources = import ./npins;
  pkgs = import npins-sources.nixpkgs {
    overlays = [
      (final: prev: {
        inherit npins-sources;

        npingler-lib = final.callPackage "${npins-sources.npingler}/lib" { };
      })
    ];
  };
  profile = pkgs.npingler-lib.makeProfile {
    pins = {
      # A map of names to `source` derivations. These get pinned in the `nix
      # registry` so that (e.g.) `nix repl nixpkgs` uses the same version of
      # `nixpkgs` as your profile, and also in your Nix channels, so that
      # `nix-shell -p hello` uses the same version as well.
      nixpkgs = npins-sources.nixpkgs;
    };

    paths = [
      pkgs.direnv
      pkgs.fd
      pkgs.fish
      pkgs.fnm
      pkgs.fzf
      pkgs.gh
      pkgs.git
      pkgs.graphviz
      pkgs.jq
      pkgs.jujutsu
      pkgs.neovim
      pkgs.nix-direnv
      pkgs.nix-your-shell
      pkgs.npingler
      pkgs.npins
      pkgs.ripgrep
      pkgs.watchman
    ];
  };
in
{
  npingler = {
    # By default, npingler uses the attr matching your hostname.
    sunbird = profile;
    rook = profile;
  };
}


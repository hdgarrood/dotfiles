let
  sources = import ./npins;

  pkgs = import sources.nixpkgs {
    overlays = [
      (final: prev: {
        npingler-lib = final.callPackage "${sources.npingler}/lib" { };
      })
      (final: prev: {
        hdgarrood = final.callPackage ./makePkgs.nix { };
      })
    ];
  };

  profile = pkgs.npingler-lib.makeProfile {
    pins = {
      # A map of names to `source` derivations. These get pinned in the `nix
      # registry` so that (e.g.) `nix repl nixpkgs` uses the same version of
      # `nixpkgs` as your profile, and also in your Nix channels, so that
      # `nix-shell -p hello` uses the same version as well.
      nixpkgs = sources.nixpkgs;
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
      pkgs.hdgarrood.nix-direnv
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


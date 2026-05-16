let
  sources = import ./npins;

  pkgs = import sources.nixpkgs {
    overlays = [
      (final: prev: {
        npingler-lib = final.callPackage "${sources.npingler}/lib" { };
        hdgarrood = final.callPackage ./makePkgs.nix { } // {
          makeManifest = final.callPackage ./makeManifest.nix { };
        };
      })
    ];
  };

  # A map of names to `source` derivations. These get pinned in the `nix
  # registry` so that (e.g.) `nix repl nixpkgs` uses the same version of
  # `nixpkgs` as your profile, and also in your Nix channels, so that
  # `nix-shell -p hello` uses the same version as well.
  pins = {
    nixpkgs = sources.nixpkgs;
  };

  # Packages to be added to your profile.
  paths = [
    pkgs.buck2 # for completions, mainly.
    pkgs.coreutils
    pkgs.eza
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
    pkgs.nix-your-shell
    pkgs.nixfmt
    pkgs.npingler
    pkgs.npins
    pkgs.numbat
    pkgs.ripgrep
    pkgs.ruby
    pkgs.terminal-notifier
    pkgs.treefmt
    pkgs.watchman

    pkgs.hdgarrood.nix-direnv # for the "print at most 5 changed files" patch only
    pkgs.hdgarrood.jj-prompt-info
    pkgs.hdgarrood.nix-prompt-info
  ];

  profile = pkgs.npingler-lib.makeProfile {
    inherit pins;
    paths =
      let
        manifest = pkgs.hdgarrood.makeManifest { inherit paths; };
      in
      paths ++ [ manifest ];
  };
in
{
  inherit
    sources
    pkgs
    pins
    paths
    ;

  npingler = {
    # By default, npingler uses the attr matching your hostname.
    sunbird = profile;
    rook = profile;
  };
}

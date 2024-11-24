{
  description = "Alternative Haskell Infrastructure for Nixpkgs";

  inputs = {
    nixpkgs.follows = "nixpkgs-2405";
    nixpkgs-2405 = { url = "github:NixOS/nixpkgs/release-24.05"; };
    flake-compat = { url = "github:input-output-hk/flake-compat/hkm/gitlab-fix"; flake = false; };
    hydra.url = "hydra";
    hackage = {
      url = "github:kronor-io/hackage.nix/main";
      flake = false;
    };
    stackage = {
      url = "github:input-output-hk/stackage.nix";
      flake = false;
    };
    nix-tools-static = {
      url = "github:input-output-hk/haskell-nix-example/nix";
      flake = false;
    };
    cabal-36 = {
      url = "github:haskell/cabal/3.6";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-compat
    , ...
    }@inputs:
    let
      callFlake = import flake-compat;

      config = import ./config.nix;

      inherit (nixpkgs) lib;

      # systems supported by haskell.nix
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      nixpkgsArgs = {
        inherit config;
        overlays = [ self.overlay ];
      };

      forEachSystem = lib.genAttrs systems;
      forEachSystemPkgs = f: forEachSystem (system: f self.legacyPackages.${system});

    in {
      inherit config;
      overlay = self.overlays.combined;
      overlays = import ./overlays { sources = inputs; };

      internal = {
        nixpkgsArgs = {
          inherit config;
          overlays = [ self.overlay ];
        };

        sources = inputs;

        overlaysOverrideable =
          lib.warn
            "Using this attribute is deprecated. Import ${./overlays} directly or use the flake overlays output with override-inut."
            (import ./overlays);

        # Compatibility with old default.nix
        compat =
          lib.warn
            "Using this attribute is deprecated. You can pass the same arguments to ${./default.nix} instead"
            (import ./default.nix);
      };

      legacyPackages = forEachSystem (system:
        import nixpkgs {
          inherit config;
          overlays = [ self.overlay ];
          localSystem = { inherit system; };
        });
    };

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    # This sets the flake to use the IOG nix cache.
    # Nix should ask for permission before using it,
    # but remove it here if you do not want it to.
    extra-substituters = ["https://cache.iog.io"];
    extra-trusted-public-keys = ["hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
    allow-import-from-derivation = "true";
  };
}

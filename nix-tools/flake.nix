{
  description = "Flake for building nix-tools with nixpkgs infra";

  inputs.nixpkgs.follows = "nixpkgs-2405";
  inputs.nixpkgs-2405.url = "github:NixOS/nixpkgs/release-24.05";

  inputs.hackage-db.url = "github:michaelpj/hackage-db/83f819cb08742d3c86a83b407d45c1f6c1c7e299";
  inputs.hackage-db.flake = false;

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      compiler = "ghc981";

      # keep it simple (from https://ayats.org/blog/no-flake-utils/)
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f (import nixpkgs {
            inherit system;
            overlays = [
              (import ./overlay.nix { hackage-db-src = "${inputs.hackage-db}"; })
            ];
          }));

    in
    {
      packages = forAllSystems (pkgs:
        {
          nix-tools = pkgs.haskell.packages.ghc981.nix-tools;
          pkgs = pkgs;
        });
    };

  nixConfig = {
    extra-substituters = [
      "https://cache.iog.io"
      "https://cache.zw3rk.com"
    ];
    extra-trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
    ];
    allow-import-from-derivation = "true";
  };
}

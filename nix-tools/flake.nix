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

      nix-tools-overlays = final: prev: {
        haskell = prev.haskell // {
          packages = prev.haskell.packages // {
            "${compiler}" = prev.haskell.packages."${compiler}".override
              (old: {
                overrides = final.lib.fold final.lib.composeExtensions
                  (old.overrides or (_: _: { })) [
                    (hfinal: hprev:
                      let
                        fetchFromHackage = pname: version: hash:
                          hfinal.callHackageDirect {
                            pkg = pname;
                            ver = version;
                            sha256 = hash;
                          };
                        ps-cabal-install-solver = (fetchFromHackage "cabal-install-solver" "3.10.2.1" "sha256-wNwp42fiEketjcKJwhv5etP5/bVGlDitnMryTLX+Z74=") {};
                        ps-cabal-install = (fetchFromHackage "cabal-install" "3.10.2.1" "sha256-encWM587n+atIrbjHaNjNeavBoxmMsI1QXDS5AtOLoo=") {Cabal-described = null; Cabal-QuickCheck = null; Cabal-tree-diff = null; cabal-install-solver = ps-cabal-install-solver;};
                      in {
                        ps-cabal-install = ps-cabal-install;
                        ps-cabal-install-solver = ps-cabal-install-solver;
                    })
                    (hfinal: hprev:
                      {
                        nix-tools = final.haskell.lib.dontCheck (final.haskell.lib.markUnbroken (hfinal.callCabal2nix "nix-tools" ./nix-tools {
                          cabal-install = hfinal.ps-cabal-install;
                          cabal-install-solver = hfinal.ps-cabal-install-solver;
                        }));

                        hackage-db = hfinal.callCabal2nix "hackage-db" "${inputs.hackage-db}" {};
                    })
                  ];
              });
          };
        };
      };

      # keep it simple (from https://ayats.org/blog/no-flake-utils/)
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f (import nixpkgs {
            inherit system;
            overlays = [
              nix-tools-overlays
            ];
          }));

    in
    {
      packages = forAllSystems (pkgs:
        {
          nix-tools = pkgs.haskell.packages.ghc981.nix-tools;
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

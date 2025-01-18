{ sources }:
let
  overlays = {
    cabal-install-overlay = final: prev:
      { bootstrap-cabal-install =
          let
            cabal-install-src = final.pkgs.fetchurl {
                  url = "https://hackage.haskell.org/package/cabal-install-3.14.1.1/cabal-install-3.14.1.1.tar.gz";
                  sha256 = "sha256-8R02Srh/tGJ1qYfmBFOFdzIUd4CoxZJGDuyKFtu2us4=";
                };
            cabal-install-pkgs = final.haskell-nix.cabalProjectWithPlan
              { src = cabal-install-src;
                compiler-nix-name = "ghc912";
                cabalProject = ''
                  packages:
                    ./cabal-install.cabal
                  package cabal-install
                    tests: false
                '';
              }
              (_: {
                "extra-hackages" = [];
                "index-state-max" = "2025-01-17T00:00:00Z";
                "projectNix" = ../materialized/cabal-install-3.14.1.1;
                "sourceRepos" = [];
                "src" = cabal-install-src;
              });
          in cabal-install-pkgs.hsPkgs.cabal-install.components.exes.cabal;
      };

    haskell = import ./haskell.nix { inherit sources; };

    # Here is where we import nix-tools into the overlays that haskell.nix is
    # going to use.
    nix-tools = (final: prev:
      let

        # Import the overlay from nix-tools' subdirectory
        nix-tools-exes = final.callPackage ./nix-tools.nix {};

      in
      {
        haskell-nix =
          prev.haskell-nix // {
            nix-tools =
              let nix-tools-pkgs = final.haskell-nix.cabalProjectWithPlan
                    { src = ../nix-tools; compiler-nix-name = "ghc912"; }
                    (_: {
                    "extra-hackages" = [];
                    "index-state-max" = "2025-01-17T00:00:00Z";
                    "projectNix" = ../materialized/nix-tools;
                    "sourceRepos" = [
                      (final.pkgs.fetchgit {
                        url = "https://github.com/kronor-io/hackage-db";
                        sha256 = "11g395vrrsaasl1ssk8qfbcc9wx6aygipsldyclgn4szpm4xzm7h";
                        rev = "83f819cb08742d3c86a83b407d45c1f6c1c7e299";
                      })
                    ];
                    "src" = ../nix-tools;
                    });
              in {
                exes = {
                  truncate-index = nix-tools-pkgs.hsPkgs.nix-tools.components.exes.truncate-index;
                  make-install-plan = nix-tools-pkgs.hsPkgs.nix-tools.components.exes.make-install-plan;
                  plan-to-nix = nix-tools-pkgs.hsPkgs.nix-tools.components.exes.plan-to-nix;
                  hackage-to-nix = nix-tools-pkgs.hsPkgs.nix-tools.components.exes.hackage-to-nix;
                };
              };
          };
      });

    bootstrap = import ./bootstrap.nix;
    ghc = import ./ghc.nix;
    ghc-packages = import ./ghc-packages.nix;
    musl = import ./musl.nix;
    tools = import ./tools.nix;
    nix-prefetch-git-minimal = import ./nix-prefetch-git-minimal.nix;
    cabalPkgConfig = import ./cabal-pkg-config.nix;
    default-setup = import ./default-setup.nix;
    dummy-ghc-data = import ./dummy-ghc-data.nix;
    fetch-source = import ./fetch-source.nix;
  };

  composeExtensions = f: g: final: prev:
    let
      fApplied = f final prev;
      prev' = prev // fApplied;
    in fApplied // g final prev';

  ordered = with overlays; [
    # Hide nixpkgs haskell and haskellPackages from the haskell-nix overlays.
    # This should prevent us inadvertently depending on them.
    # (_: prev: {
    #   haskell = { };
    #   haskellPackages = { };
    #   haskell-nix-prev = prev;
    # })
    cabal-install-overlay
    haskell
    nix-tools
    bootstrap
    # ghc
    # ghc-packages
    musl
    tools
    nix-prefetch-git-minimal
    cabalPkgConfig
    # Restore nixpkgs haskell and haskellPackages
    # (_: prev: { inherit (prev.haskell-nix-prev) haskell haskellPackages; })
    dummy-ghc-data
    default-setup
    fetch-source
  ];
  combined = builtins.foldl' composeExtensions (_: _: { }) ordered;
in overlays // { inherit combined; }

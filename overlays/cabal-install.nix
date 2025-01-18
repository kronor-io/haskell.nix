final: prev:
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
          index-state = "2025-01-13T20:06:10Z";
        }
        (_: {
          "extra-hackages" = [];
          "index-state-max" = "2025-01-17T00:00:00Z";
          "projectNix" = ../materialized/cabal-install-3.14.1.1;
          "sourceRepos" = [];
          "src" = cabal-install-src;
        });
    in cabal-install-pkgs.hsPkgs.cabal-install.components.exes.cabal;
}

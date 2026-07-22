final: prev:
{ bootstrap-cabal-install =
    let
      cabal-install-src = final.pkgs.fetchzip {
            url = "https://hackage.haskell.org/package/cabal-install-3.16.1.0/cabal-install-3.16.1.0.tar.gz";
            sha256 = "sha256-6ssSeM1oeXVCLR5/HPxYEUkcEWU8XxlqZiBl1JHbMbw=";
          };
      cabal-install-pkgs = final.haskell-nix.cabalProjectWithPlan

        { src = cabal-install-src;
          compiler-nix-name = "ghc9141";
          cabalProject = ''
            packages:
              ./cabal-install.cabal
            package cabal-install
              tests: false

            allow-newer:
              cabal-install:base,
              cabal-install:HTTP,
              cabal-install:time,
              cabal-install:open-browser
          '';
          index-state = "2026-06-30T23:54:30Z";
        }
        (_: {
          "extra-hackages" = [];
          "index-state-max" = "2026-06-30T23:54:30Z";
          "projectNix" = ../materialized/cabal-install-3.16.1.0;
          "sourceRepos" = [];
          "src" = cabal-install-src;
        });
    in cabal-install-pkgs.hsPkgs.cabal-install.components.exes.cabal;
}

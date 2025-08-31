final: prev:
{ bootstrap-cabal-install =
    let
      cabal-install-src = final.pkgs.fetchzip {
            url = "https://hackage.haskell.org/package/cabal-install-3.16.0.0/cabal-install-3.16.0.0.tar.gz";
            sha256 = "sha256-pO6fGJ8saFRB+vU0LqUJ+AhqTMR/AkFvbHsSyaGxQKY=";
          };
      cabal-install-pkgs = final.haskell-nix.cabalProjectWithPlan

        { src = cabal-install-src;
          compiler-nix-name = "ghc9122";
          cabalProject = ''
            packages:
              ./cabal-install.cabal
            package cabal-install
              tests: false
          '';
          index-state = "2025-08-29T19:12:50Z";
        }
        (_: {
          "extra-hackages" = [];
          "index-state-max" = "2025-08-29T19:12:50Z";
          "projectNix" = ../materialized/cabal-install-3.16.0.0; # planned for ghc9122
          "sourceRepos" = [];
          "src" = cabal-install-src;
        });
    in cabal-install-pkgs.hsPkgs.cabal-install.components.exes.cabal;
}

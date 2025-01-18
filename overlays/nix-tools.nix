final: prev:
{
  haskell-nix =
    prev.haskell-nix // {
      nix-tools =
        let nix-tools-pkgs = final.haskell-nix.cabalProjectWithPlan
              { src = ../nix-tools; compiler-nix-name = "ghc912"; index-state = "2025-01-13T20:06:10Z"; }
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
}

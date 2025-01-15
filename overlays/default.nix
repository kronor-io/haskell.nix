{ sources }:
let
  overlays = {
    cabal-install-overlay = final: prev: { bootstrap-cabal-install = final.callPackage ./cabal-install.nix {};};

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
            nix-tools = {
              exes =
                  {
                    truncate-index = nix-tools-exes;
                    make-install-plan = nix-tools-exes;
                    plan-to-nix = nix-tools-exes;
                    hackage-to-nix = nix-tools-exes;
                  };
              inherit nix-tools-exes;
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

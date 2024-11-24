{ hackage-db-src ? null}:
let

  compiler = "ghc981";

in

final: prev: {
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

                        hackage-db =
                          let
                            hackage-db-git = if hackage-db-src == null then final.fetchgit {
                              url = "https://github.com/michaelpj/hackage-db.git";
                              rev = "83f819cb08742d3c86a83b407d45c1f6c1c7e299";
                              sha256 = "sha256-8NTfSb1fE/so843qG59XpvPE2HIYTa0D1UrpnHdJ44U=";
                            }
                            else hackage-db-src;

                          in hfinal.callCabal2nix "hackage-db" hackage-db-git {};
                    })
                  ];
              });
          };
        };
      }

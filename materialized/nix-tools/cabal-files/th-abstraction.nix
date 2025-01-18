{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  ({
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "th-abstraction"; version = "0.7.1.0"; };
      license = "ISC";
      copyright = "2017 Eric Mertens";
      maintainer = "emertens@gmail.com";
      author = "Eric Mertens";
      homepage = "https://github.com/glguy/th-abstraction";
      url = "";
      synopsis = "Nicer interface for reified information about data types";
      description = "This package normalizes variations in the interface for\ninspecting datatype information via Template Haskell\nso that packages and support a single, easier to use\ninformational datatype while supporting many versions\nof Template Haskell.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."ghc-prim" or (errorHandler.buildDepError "ghc-prim"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
        ];
        buildable = true;
      };
      tests = {
        "unit-tests" = {
          depends = [
            (hsPkgs."th-abstraction" or (errorHandler.buildDepError "th-abstraction"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/th-abstraction-0.7.1.0.tar.gz";
      sha256 = "f9b6184aba4c6b61dd0d96f7dad41a4c9db0a01d3cdbf993a7d860488f1c04c5";
    });
  }) // {
    package-description-override = "name:                th-abstraction\nversion:             0.7.1.0\nsynopsis:            Nicer interface for reified information about data types\ndescription:         This package normalizes variations in the interface for\n                     inspecting datatype information via Template Haskell\n                     so that packages and support a single, easier to use\n                     informational datatype while supporting many versions\n                     of Template Haskell.\nlicense:             ISC\nlicense-file:        LICENSE\nauthor:              Eric Mertens\nmaintainer:          emertens@gmail.com\ncopyright:           2017 Eric Mertens\nhomepage:            https://github.com/glguy/th-abstraction\nbug-reports:         https://github.com/glguy/th-abstraction/issues\ncategory:            Development\nbuild-type:          Simple\nextra-source-files:  ChangeLog.md README.md\ncabal-version:       >=1.10\ntested-with:         GHC==9.12.1, GHC==9.10.1, GHC==9.8.4, GHC==9.6.6, GHC==9.4.8, GHC==9.2.8, GHC==9.0.2, GHC==8.10.7, GHC==8.8.4, GHC==8.6.5, GHC==8.4.4, GHC==8.2.2, GHC==8.0.2\n\nsource-repository head\n  type: git\n  location: https://github.com/glguy/th-abstraction.git\n\nlibrary\n  exposed-modules:     Language.Haskell.TH.Datatype\n                       Language.Haskell.TH.Datatype.TyVarBndr\n  other-modules:       Language.Haskell.TH.Datatype.Internal\n  build-depends:       base             >=4.9   && <5,\n                       ghc-prim,\n                       template-haskell >=2.11  && <2.24,\n                       containers       >=0.4   && <0.8\n  hs-source-dirs:      src\n  default-language:    Haskell2010\n\n  if impl(ghc >= 9.0)\n    -- these flags may abort compilation with GHC-8.10\n    -- https://gitlab.haskell.org/ghc/ghc/-/merge_requests/3295\n    ghc-options: -Winferred-safe-imports -Wmissing-safe-haskell-mode\n\ntest-suite unit-tests\n  other-modules:       Harness\n                       Types\n  type:                exitcode-stdio-1.0\n  main-is:             Main.hs\n  build-depends:       th-abstraction, base, containers, template-haskell\n  hs-source-dirs:      test\n  default-language:    Haskell2010\n\n  if impl(ghc >= 8.6)\n    ghc-options:       -Wno-star-is-type\n";
  }
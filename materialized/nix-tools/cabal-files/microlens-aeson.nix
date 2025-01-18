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
      specVersion = "2.2";
      identifier = { name = "microlens-aeson"; version = "2.5.2"; };
      license = "MIT";
      copyright = "Copyright (C) 2012 Paul Wilson, (C) 2013 Edward A. Kmett, (C) 2015 Colin Woodbury";
      maintainer = "Colin Woodbury <colin@fosskers.ca>";
      author = "Colin Woodbury";
      homepage = "http://github.com/fosskers/microlens-aeson/";
      url = "";
      synopsis = "Law-abiding lenses for Aeson, using microlens";
      description = "Law-abiding lenses for Aeson, using microlens.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."hashable" or (errorHandler.buildDepError "hashable"))
          (hsPkgs."microlens" or (errorHandler.buildDepError "microlens"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."vector" or (errorHandler.buildDepError "vector"))
          (hsPkgs."attoparsec" or (errorHandler.buildDepError "attoparsec"))
          (hsPkgs."scientific" or (errorHandler.buildDepError "scientific"))
        ];
        buildable = true;
      };
      tests = {
        "microlens-aeson-test" = {
          depends = [
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."hashable" or (errorHandler.buildDepError "hashable"))
            (hsPkgs."microlens" or (errorHandler.buildDepError "microlens"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."vector" or (errorHandler.buildDepError "vector"))
            (hsPkgs."microlens-aeson" or (errorHandler.buildDepError "microlens-aeson"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/microlens-aeson-2.5.2.tar.gz";
      sha256 = "6c76be50168b12c8ac67229127d78555e915de91382119a61801f3f1a256d5b2";
    });
  }) // {
    package-description-override = "cabal-version:      2.2\nname:               microlens-aeson\nversion:            2.5.2\nsynopsis:           Law-abiding lenses for Aeson, using microlens\ndescription:        Law-abiding lenses for Aeson, using microlens.\ncategory:           Numeric\nhomepage:           http://github.com/fosskers/microlens-aeson/\nauthor:             Colin Woodbury\nmaintainer:         Colin Woodbury <colin@fosskers.ca>\ncopyright:\n  Copyright (C) 2012 Paul Wilson, (C) 2013 Edward A. Kmett, (C) 2015 Colin Woodbury\ntested-with:\n    GHC==9.8.1\n  , GHC==9.6.4\n  , GHC==9.4.8\n  , GHC==9.2.8\n  , GHC==9.0.2\n  , GHC==8.10.7\n\nlicense:            MIT\nlicense-file:       LICENSE\nbuild-type:         Simple\nextra-doc-files:\n  AUTHORS.md\n  README.md\n  CHANGELOG.md\n  microlens-aeson.png\n  lens-aeson.png\n\ncommon commons\n  default-language: Haskell2010\n  ghc-options:      -Wall -fwarn-incomplete-record-updates\n  build-depends:\n    , aeson                 >=2.0\n    , base                  >=4.9   && <5\n    , bytestring\n    , hashable\n    , microlens             >=0.3\n    , text                  >=0.11 && < 1.3 || >= 2.0 && < 2.2\n    , vector                >=0.9\n\nlibrary\n  import:          commons\n  hs-source-dirs:  src\n  exposed-modules: Lens.Micro.Aeson\n  other-modules:   Lens.Micro.Aeson.Internal\n  build-depends:\n    , attoparsec  >=0.10\n    , scientific  >=0.3.2\n\ntest-suite microlens-aeson-test\n  import:         commons\n  type:           exitcode-stdio-1.0\n  hs-source-dirs: test\n  main-is:        Test.hs\n  ghc-options:    -threaded -with-rtsopts=-N\n  build-depends:\n    , microlens-aeson\n    , tasty            >=0.10.1.2\n    , tasty-hunit      >=0.9.2\n";
  }
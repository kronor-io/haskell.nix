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
      identifier = { name = "half"; version = "0.3.2"; };
      license = "BSD-3-Clause";
      copyright = "Copyright (C) 2014 Edward A. Kmett";
      maintainer = "Edward A. Kmett <ekmett@gmail.com>";
      author = "Edward A. Kmett";
      homepage = "http://github.com/ekmett/half";
      url = "";
      synopsis = "Half-precision floating-point";
      description = "Half-precision floating-point.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."binary" or (errorHandler.buildDepError "binary"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
        ];
        buildable = true;
      };
      tests = {
        "spec" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."binary" or (errorHandler.buildDepError "binary"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."half" or (errorHandler.buildDepError "half"))
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."test-framework" or (errorHandler.buildDepError "test-framework"))
            (hsPkgs."test-framework-quickcheck2" or (errorHandler.buildDepError "test-framework-quickcheck2"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/half-0.3.2.tar.gz";
      sha256 = "19992e9fb6f4ea8a53b0ba0693565e8ec73c620b603e74b6d4f262e49d7df038";
    });
  }) // {
    package-description-override = "cabal-version: >=1.10\nname: half\nversion: 0.3.2\nlicense: BSD3\nlicense-file: LICENSE\ncopyright: Copyright (C) 2014 Edward A. Kmett\nmaintainer: Edward A. Kmett <ekmett@gmail.com>\nauthor: Edward A. Kmett\nstability: provisional\nhomepage: http://github.com/ekmett/half\nbug-reports: http://github.com/ekmett/half/issues\nsynopsis: Half-precision floating-point\ndescription:\n    Half-precision floating-point.\ncategory: Numeric\nbuild-type: Simple\nextra-source-files:\n    .gitignore\n    README.markdown\n    CHANGELOG.markdown\n\ntested-with:   GHC == 8.0.2\n             , GHC == 8.2.2\n             , GHC == 8.4.4\n             , GHC == 8.6.5\n             , GHC == 8.8.4\n             , GHC == 8.10.7\n             , GHC == 9.0.2\n             , GHC == 9.2.8\n             , GHC == 9.4.8\n             , GHC == 9.6.6\n             , GHC == 9.8.4\n             , GHC == 9.10.1\n             , GHC == 9.12.1\n\nsource-repository head\n    type: git\n    location: git://github.com/ekmett/half.git\n\nlibrary\n    default-language: Haskell2010\n    exposed-modules:\n        Numeric.Half\n        Numeric.Half.Internal\n    hs-source-dirs: src\n    other-extensions: BangPatterns CPP DeriveDataTypeable DeriveGeneric\n                      DeriveLift ForeignFunctionInterface PatternSynonyms\n                      StandaloneDeriving\n    ghc-options: -Wall -Wtabs -O2 -Wno-missing-pattern-synonym-signatures\n    build-depends:\n        base >=4.9 && <5,\n        binary >=0.5.1.0 && <0.9,\n        deepseq >=1.4.2.0 && <1.6,\n        template-haskell >=2.11\n\n    if !impl(ghcjs)\n      c-sources:\n        cbits/half.c\n\ntest-suite spec\n    default-language: Haskell2010\n    type: exitcode-stdio-1.0\n    main-is: Spec.hs\n    hs-source-dirs: test\n    ghc-options: -Wall\n\n    build-depends:\n        base,\n        binary,\n        bytestring,\n        half,\n        QuickCheck >=2.14.1 && <2.16,\n        test-framework,\n        test-framework-quickcheck2\n";
  }
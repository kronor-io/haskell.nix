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
      specVersion = "1.12";
      identifier = { name = "typed-process"; version = "0.2.12.0"; };
      license = "MIT";
      copyright = "";
      maintainer = "michael@snoyman.com";
      author = "Michael Snoyman";
      homepage = "https://github.com/fpco/typed-process";
      url = "";
      synopsis = "Run external processes, with strong typing of streams";
      description = "Please see the tutorial at <https://github.com/fpco/typed-process#readme>";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."async" or (errorHandler.buildDepError "async"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."process" or (errorHandler.buildDepError "process"))
          (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
          (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
          (hsPkgs."unliftio-core" or (errorHandler.buildDepError "unliftio-core"))
        ];
        buildable = true;
      };
      tests = {
        "typed-process-test" = {
          depends = [
            (hsPkgs."async" or (errorHandler.buildDepError "async"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."base64-bytestring" or (errorHandler.buildDepError "base64-bytestring"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."hspec" or (errorHandler.buildDepError "hspec"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
            (hsPkgs."temporary" or (errorHandler.buildDepError "temporary"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."typed-process" or (errorHandler.buildDepError "typed-process"))
            (hsPkgs."unliftio-core" or (errorHandler.buildDepError "unliftio-core"))
          ];
          build-tools = [
            (hsPkgs.buildPackages.hspec-discover.components.exes.hspec-discover or (pkgs.buildPackages.hspec-discover or (errorHandler.buildToolDepError "hspec-discover:hspec-discover")))
          ];
          buildable = true;
        };
        "typed-process-test-single-threaded" = {
          depends = [
            (hsPkgs."async" or (errorHandler.buildDepError "async"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."base64-bytestring" or (errorHandler.buildDepError "base64-bytestring"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."hspec" or (errorHandler.buildDepError "hspec"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
            (hsPkgs."temporary" or (errorHandler.buildDepError "temporary"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."typed-process" or (errorHandler.buildDepError "typed-process"))
            (hsPkgs."unliftio-core" or (errorHandler.buildDepError "unliftio-core"))
          ];
          build-tools = [
            (hsPkgs.buildPackages.hspec-discover.components.exes.hspec-discover or (pkgs.buildPackages.hspec-discover or (errorHandler.buildToolDepError "hspec-discover:hspec-discover")))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/typed-process-0.2.12.0.tar.gz";
      sha256 = "4cee3d3ae851de720f40ce671510c04b7938ca76552952bd7c5e8b1bec161be1";
    });
  }) // {
    package-description-override = "cabal-version: 1.12\n\n-- This file has been generated from package.yaml by hpack version 0.37.0.\n--\n-- see: https://github.com/sol/hpack\n\nname:           typed-process\nversion:        0.2.12.0\nsynopsis:       Run external processes, with strong typing of streams\ndescription:    Please see the tutorial at <https://github.com/fpco/typed-process#readme>\ncategory:       System\nhomepage:       https://github.com/fpco/typed-process\nbug-reports:    https://github.com/fpco/typed-process/issues\nauthor:         Michael Snoyman\nmaintainer:     michael@snoyman.com\nlicense:        MIT\nlicense-file:   LICENSE\nbuild-type:     Simple\nextra-source-files:\n    README.md\n    ChangeLog.md\n\nsource-repository head\n  type: git\n  location: https://github.com/fpco/typed-process\n\nlibrary\n  exposed-modules:\n      System.Process.Typed\n      System.Process.Typed.Internal\n  other-modules:\n      Paths_typed_process\n  hs-source-dirs:\n      src\n  build-depends:\n      async >=2.0\n    , base >=4.12 && <5\n    , bytestring\n    , process >=1.2\n    , stm\n    , transformers\n    , unliftio-core\n  default-language: Haskell2010\n  if os(windows)\n    cpp-options: -DWINDOWS\n\ntest-suite typed-process-test\n  type: exitcode-stdio-1.0\n  main-is: Spec.hs\n  other-modules:\n      System.Process.TypedSpec\n      Paths_typed_process\n  hs-source-dirs:\n      test\n  ghc-options: -threaded -rtsopts -with-rtsopts=-N\n  build-tool-depends:\n      hspec-discover:hspec-discover\n  build-depends:\n      async >=2.0\n    , base >=4.12 && <5\n    , base64-bytestring\n    , bytestring\n    , hspec ==2.*\n    , process >=1.2\n    , stm\n    , temporary\n    , transformers\n    , typed-process\n    , unliftio-core\n  default-language: Haskell2010\n\ntest-suite typed-process-test-single-threaded\n  type: exitcode-stdio-1.0\n  main-is: Spec.hs\n  other-modules:\n      System.Process.TypedSpec\n      Paths_typed_process\n  hs-source-dirs:\n      test\n  build-tool-depends:\n      hspec-discover:hspec-discover\n  build-depends:\n      async >=2.0\n    , base >=4.12 && <5\n    , base64-bytestring\n    , bytestring\n    , hspec ==2.*\n    , process >=1.2\n    , stm\n    , temporary\n    , transformers\n    , typed-process\n    , unliftio-core\n  default-language: Haskell2010\n";
  }
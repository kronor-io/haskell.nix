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
    flags = { bounded_memory = false; };
    package = {
      specVersion = "2.2";
      identifier = { name = "hnix-store-core"; version = "0.6.1.0"; };
      license = "Apache-2.0";
      copyright = "2018 Shea Levy";
      maintainer = "shea@shealevy.com";
      author = "Shea Levy";
      homepage = "https://github.com/haskell-nix/hnix-store";
      url = "";
      synopsis = "Core effects for interacting with the Nix store.";
      description = "This package contains types and functions needed to describe\ninteractions with the Nix store abstracted away from\nspecific effectful context.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."relude" or (errorHandler.buildDepError "relude"))
          (hsPkgs."attoparsec" or (errorHandler.buildDepError "attoparsec"))
          (hsPkgs."algebraic-graphs" or (errorHandler.buildDepError "algebraic-graphs"))
          (hsPkgs."base16-bytestring" or (errorHandler.buildDepError "base16-bytestring"))
          (hsPkgs."base64-bytestring" or (errorHandler.buildDepError "base64-bytestring"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."cereal" or (errorHandler.buildDepError "cereal"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."memory" or (errorHandler.buildDepError "memory"))
          (hsPkgs."cryptonite" or (errorHandler.buildDepError "cryptonite"))
          (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
          (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
          (hsPkgs."hashable" or (errorHandler.buildDepError "hashable"))
          (hsPkgs."lifted-base" or (errorHandler.buildDepError "lifted-base"))
          (hsPkgs."monad-control" or (errorHandler.buildDepError "monad-control"))
          (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
          (hsPkgs."nix-derivation" or (errorHandler.buildDepError "nix-derivation"))
          (hsPkgs."saltine" or (errorHandler.buildDepError "saltine"))
          (hsPkgs."time" or (errorHandler.buildDepError "time"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."unix" or (errorHandler.buildDepError "unix"))
          (hsPkgs."unordered-containers" or (errorHandler.buildDepError "unordered-containers"))
          (hsPkgs."vector" or (errorHandler.buildDepError "vector"))
        ];
        buildable = true;
      };
      tests = {
        "format-tests" = {
          depends = [
            (hsPkgs."hnix-store-core" or (errorHandler.buildDepError "hnix-store-core"))
            (hsPkgs."attoparsec" or (errorHandler.buildDepError "attoparsec"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."relude" or (errorHandler.buildDepError "relude"))
            (hsPkgs."base16-bytestring" or (errorHandler.buildDepError "base16-bytestring"))
            (hsPkgs."base64-bytestring" or (errorHandler.buildDepError "base64-bytestring"))
            (hsPkgs."binary" or (errorHandler.buildDepError "binary"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."cryptonite" or (errorHandler.buildDepError "cryptonite"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-golden" or (errorHandler.buildDepError "tasty-golden"))
            (hsPkgs."hspec" or (errorHandler.buildDepError "hspec"))
            (hsPkgs."tasty-hspec" or (errorHandler.buildDepError "tasty-hspec"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
            (hsPkgs."tasty-quickcheck" or (errorHandler.buildDepError "tasty-quickcheck"))
            (hsPkgs."temporary" or (errorHandler.buildDepError "temporary"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."unix" or (errorHandler.buildDepError "unix"))
          ];
          build-tools = [
            (hsPkgs.pkgsBuildBuild.tasty-discover.components.exes.tasty-discover or (pkgs.pkgsBuildBuild.tasty-discover or (errorHandler.buildToolDepError "tasty-discover:tasty-discover")))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/hnix-store-core-0.6.1.0.tar.gz";
      sha256 = "779c1ea6802b0ff4f217d95c7ad9963cf136c9d180f07f9db0182ab695e0f1af";
    });
  }) // {
    package-description-override = "cabal-version:       2.2\nname:                hnix-store-core\nversion:             0.6.1.0\nsynopsis:            Core effects for interacting with the Nix store.\ndescription:\n  This package contains types and functions needed to describe\n  interactions with the Nix store abstracted away from\n  specific effectful context.\nhomepage:            https://github.com/haskell-nix/hnix-store\nlicense:             Apache-2.0\nlicense-file:        LICENSE\nauthor:              Shea Levy\nmaintainer:          shea@shealevy.com\ncopyright:           2018 Shea Levy\ncategory:            Nix\nbuild-type:          Simple\nextra-source-files:\n    ChangeLog.md\n  , README.md\n  , tests/samples/example0.drv\n  , tests/samples/example1.drv\n\nCommon commons\n  if impl(ghc >= 8.10)\n    ghc-options:  -Wall -Wunused-packages\n  else\n    ghc-options:  -Wall\n\nlibrary\n  import: commons\n  exposed-modules:\n      System.Nix.Base32\n    , System.Nix.Build\n    , System.Nix.Derivation\n    , System.Nix.Hash\n    , System.Nix.Internal.Base\n    , System.Nix.Internal.Base32\n    , System.Nix.Internal.Truncation\n    , System.Nix.Internal.Hash\n    , System.Nix.Internal.Nar.Parser\n    , System.Nix.Internal.Nar.Streamer\n    , System.Nix.Internal.Nar.Effects\n    , System.Nix.Internal.Signature\n    , System.Nix.Internal.StorePath\n    , System.Nix.Nar\n    , System.Nix.ReadonlyStore\n    , System.Nix.Signature\n    , System.Nix.StorePath\n    , System.Nix.StorePathMetadata\n  build-depends:\n      base >=4.12 && <5\n    , relude >= 1.0\n    , attoparsec\n    , algebraic-graphs >= 0.5 && < 0.7\n    , base16-bytestring\n    , base64-bytestring\n    , bytestring\n    , cereal\n    , containers\n    -- Required for cryptonite low-level type convertion\n    , memory\n    , cryptonite\n    , directory\n    , filepath\n    , hashable\n    , lifted-base\n    , monad-control\n    , mtl\n    , nix-derivation >= 1.1.1 && <2\n    , saltine\n    , time\n    , text\n    , unix\n    , unordered-containers\n    , vector\n  mixins:\n      base hiding (Prelude)\n    , relude (Relude as Prelude)\n    , relude\n  default-extensions:\n      OverloadedStrings\n    , DeriveGeneric\n    , DeriveDataTypeable\n    , DeriveFunctor\n    , DeriveFoldable\n    , DeriveTraversable\n    , DeriveLift\n    , FlexibleContexts\n    , FlexibleInstances\n    , StandaloneDeriving\n    , TypeApplications\n    , TypeSynonymInstances\n    , InstanceSigs\n    , MultiParamTypeClasses\n    , TupleSections\n    , LambdaCase\n    , BangPatterns\n    , ViewPatterns\n  hs-source-dirs:      src\n  default-language:    Haskell2010\n\nFlag bounded_memory\n  description: Run tests of constant memory use (requires +RTS -T)\n  default: False\n\ntest-suite format-tests\n  import: commons\n  if flag(bounded_memory)\n    cpp-options: -DBOUNDED_MEMORY\n    ghc-options: -rtsopts -fprof-auto\n  type: exitcode-stdio-1.0\n  main-is: Driver.hs\n  other-modules:\n    Arbitrary\n    Derivation\n    NarFormat\n    Hash\n    StorePath\n  hs-source-dirs:\n    tests\n  build-tool-depends:\n    tasty-discover:tasty-discover\n  build-depends:\n      hnix-store-core\n    , attoparsec\n    , base\n    , relude\n    , base16-bytestring\n    , base64-bytestring\n    , binary\n    , bytestring\n    , containers\n    , cryptonite\n    , directory\n    , filepath\n    , process\n    , tasty\n    , tasty-golden\n    , hspec\n    , tasty-hspec\n    , tasty-hunit\n    , tasty-quickcheck\n    , temporary\n    , text\n    , unix\n  mixins:\n      base hiding (Prelude)\n    , relude (Relude as Prelude)\n    , relude\n  default-extensions:\n      OverloadedStrings\n    , DeriveGeneric\n    , DeriveDataTypeable\n    , DeriveFunctor\n    , DeriveFoldable\n    , DeriveTraversable\n    , DeriveLift\n    , FlexibleContexts\n    , FlexibleInstances\n    , StandaloneDeriving\n    , TypeApplications\n    , TypeSynonymInstances\n    , InstanceSigs\n    , MultiParamTypeClasses\n    , TupleSections\n    , LambdaCase\n    , BangPatterns\n    , ViewPatterns\n  default-language: Haskell2010\n";
  }
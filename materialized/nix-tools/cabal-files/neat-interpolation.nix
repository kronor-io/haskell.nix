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
      specVersion = "3.0";
      identifier = { name = "neat-interpolation"; version = "0.5.1.4"; };
      license = "MIT";
      copyright = "(c) 2013, Nikita Volkov";
      maintainer = "Nikita Volkov <nikita.y.volkov@mail.ru>";
      author = "Nikita Volkov <nikita.y.volkov@mail.ru>";
      homepage = "https://github.com/nikita-volkov/neat-interpolation";
      url = "";
      synopsis = "Quasiquoter for neat and simple multiline text interpolation";
      description = "Quasiquoter for producing Text values with support for\na simple interpolation of input values.\nIt removes the excessive indentation from the input and\naccurately manages the indentation of all lines of the interpolated variables.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."megaparsec" or (errorHandler.buildDepError "megaparsec"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
        ];
        buildable = true;
      };
      tests = {
        "test" = {
          depends = [
            (hsPkgs."neat-interpolation" or (errorHandler.buildDepError "neat-interpolation"))
            (hsPkgs."rerebase" or (errorHandler.buildDepError "rerebase"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/neat-interpolation-0.5.1.4.tar.gz";
      sha256 = "8eb733e3b1d90d87e0cff8b648f4b8145e38afd558f2c8343029770c9f023ab7";
    });
  }) // {
    package-description-override = "cabal-version:      3.0\nname:               neat-interpolation\nversion:            0.5.1.4\nsynopsis:\n  Quasiquoter for neat and simple multiline text interpolation\n\ndescription:\n  Quasiquoter for producing Text values with support for\n  a simple interpolation of input values.\n  It removes the excessive indentation from the input and\n  accurately manages the indentation of all lines of the interpolated variables.\n\ncategory:           String, QuasiQuotes\nlicense:            MIT\nlicense-file:       LICENSE\ncopyright:          (c) 2013, Nikita Volkov\nauthor:             Nikita Volkov <nikita.y.volkov@mail.ru>\nmaintainer:         Nikita Volkov <nikita.y.volkov@mail.ru>\nhomepage:           https://github.com/nikita-volkov/neat-interpolation\nbug-reports:        https://github.com/nikita-volkov/neat-interpolation/issues\nbuild-type:         Simple\nextra-source-files: CHANGELOG.md\n\nsource-repository head\n  type:     git\n  location: git://github.com/nikita-volkov/neat-interpolation.git\n\nlibrary\n  hs-source-dirs:     library\n  default-extensions:\n    NoImplicitPrelude\n    NoMonomorphismRestriction\n    BangPatterns\n    BinaryLiterals\n    ConstraintKinds\n    DataKinds\n    DefaultSignatures\n    DeriveDataTypeable\n    DeriveFoldable\n    DeriveFunctor\n    DeriveGeneric\n    DeriveTraversable\n    DuplicateRecordFields\n    EmptyDataDecls\n    FlexibleContexts\n    FlexibleInstances\n    FunctionalDependencies\n    GADTs\n    GeneralizedNewtypeDeriving\n    LambdaCase\n    LiberalTypeSynonyms\n    MagicHash\n    MultiParamTypeClasses\n    MultiWayIf\n    OverloadedLists\n    OverloadedStrings\n    ParallelListComp\n    PatternGuards\n    PatternSynonyms\n    QuasiQuotes\n    RankNTypes\n    RecordWildCards\n    ScopedTypeVariables\n    StandaloneDeriving\n    StrictData\n    TemplateHaskell\n    TupleSections\n    TypeApplications\n    TypeFamilies\n    TypeOperators\n    UnboxedTuples\n\n  default-language:   Haskell2010\n  exposed-modules:    NeatInterpolation\n  other-modules:\n    NeatInterpolation.Parsing\n    NeatInterpolation.Prelude\n    NeatInterpolation.String\n\n  build-depends:\n    , base >=4.9 && <5\n    , megaparsec >=7 && <10\n    , template-haskell >=2.8 && <3\n    , text >=1 && <3\n\ntest-suite test\n  type:               exitcode-stdio-1.0\n  hs-source-dirs:     test\n  default-extensions:\n    NoImplicitPrelude\n    NoMonomorphismRestriction\n    BangPatterns\n    BinaryLiterals\n    ConstraintKinds\n    DataKinds\n    DefaultSignatures\n    DeriveDataTypeable\n    DeriveFoldable\n    DeriveFunctor\n    DeriveGeneric\n    DeriveTraversable\n    DuplicateRecordFields\n    EmptyDataDecls\n    FlexibleContexts\n    FlexibleInstances\n    FunctionalDependencies\n    GADTs\n    GeneralizedNewtypeDeriving\n    LambdaCase\n    LiberalTypeSynonyms\n    MagicHash\n    MultiParamTypeClasses\n    MultiWayIf\n    OverloadedLists\n    OverloadedStrings\n    ParallelListComp\n    PatternGuards\n    PatternSynonyms\n    QuasiQuotes\n    RankNTypes\n    RecordWildCards\n    ScopedTypeVariables\n    StandaloneDeriving\n    StrictData\n    TemplateHaskell\n    TupleSections\n    TypeApplications\n    TypeFamilies\n    TypeOperators\n    UnboxedTuples\n\n  default-language:   Haskell2010\n  main-is:            Main.hs\n  build-depends:\n    , neat-interpolation\n    , rerebase <2\n    , tasty >=1.2.3 && <2\n    , tasty-hunit >=0.10.0.2 && <0.11\n";
  }
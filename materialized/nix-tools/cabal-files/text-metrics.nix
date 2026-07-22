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
    flags = { dev = false; };
    package = {
      specVersion = "2.4";
      identifier = { name = "text-metrics"; version = "0.3.3"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "Mark Karpov <markkarpov92@gmail.com>";
      author = "Mark Karpov <markkarpov92@gmail.com>";
      homepage = "https://github.com/mrkkrp/text-metrics";
      url = "";
      synopsis = "Calculate various string metrics efficiently";
      description = "Calculate various string metrics efficiently.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."vector" or (errorHandler.buildDepError "vector"))
          (hsPkgs."primitive" or (errorHandler.buildDepError "primitive"))
        ];
        buildable = true;
      };
      tests = {
        "tests" = {
          depends = [
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."hspec" or (errorHandler.buildDepError "hspec"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."text-metrics" or (errorHandler.buildDepError "text-metrics"))
          ];
          buildable = true;
        };
      };
      benchmarks = {
        "bench-speed" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."criterion" or (errorHandler.buildDepError "criterion"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."text-metrics" or (errorHandler.buildDepError "text-metrics"))
          ];
          buildable = true;
        };
        "bench-memory" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."text-metrics" or (errorHandler.buildDepError "text-metrics"))
            (hsPkgs."weigh" or (errorHandler.buildDepError "weigh"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/text-metrics-0.3.3.tar.gz";
      sha256 = "3320aa5668a9a3522f15ef85515388e0696ff9a31f15d84b1543bff654ef853e";
    });
  }) // {
    package-description-override = "cabal-version:   2.4\r\nname:            text-metrics\r\nversion:         0.3.3\r\nx-revision: 1\r\nlicense:         BSD-3-Clause\r\nlicense-file:    LICENSE.md\r\nmaintainer:      Mark Karpov <markkarpov92@gmail.com>\r\nauthor:          Mark Karpov <markkarpov92@gmail.com>\r\ntested-with:     ghc ==9.6.3 ghc ==9.8.2 ghc ==9.10.1\r\nhomepage:        https://github.com/mrkkrp/text-metrics\r\nbug-reports:     https://github.com/mrkkrp/text-metrics/issues\r\nsynopsis:        Calculate various string metrics efficiently\r\ndescription:     Calculate various string metrics efficiently.\r\ncategory:        Text, Algorithms\r\nbuild-type:      Simple\r\nextra-doc-files:\r\n    CHANGELOG.md\r\n    README.md\r\n\r\nsource-repository head\r\n    type:     git\r\n    location: https://github.com/mrkkrp/text-metrics.git\r\n\r\nflag dev\r\n    description: Turn on development settings.\r\n    default:     False\r\n    manual:      True\r\n\r\nlibrary\r\n    exposed-modules:  Data.Text.Metrics\r\n    default-language: GHC2021\r\n    build-depends:\r\n        base >=4.15 && <5,\r\n        containers >=0.5 && <0.9,\r\n        text >=0.2 && <2.2,\r\n        vector >=0.11 && <0.14,\r\n        primitive >=0.9 && <0.10\r\n\r\n    if flag(dev)\r\n        ghc-options:\r\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\r\n            -Wunused-packages\r\n\r\n    else\r\n        ghc-options: -O2 -Wall\r\n\r\ntest-suite tests\r\n    type:             exitcode-stdio-1.0\r\n    main-is:          Main.hs\r\n    hs-source-dirs:   tests\r\n    default-language: GHC2021\r\n    build-depends:\r\n        QuickCheck >=2.8 && <3,\r\n        base >=4.15 && <5,\r\n        hspec >=2.0 && <3,\r\n        text >=0.2 && <2.2,\r\n        text-metrics\r\n\r\n    if flag(dev)\r\n        ghc-options:\r\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\r\n            -Wunused-packages\r\n\r\n    else\r\n        ghc-options: -O2 -Wall\r\n\r\nbenchmark bench-speed\r\n    type:             exitcode-stdio-1.0\r\n    main-is:          Main.hs\r\n    hs-source-dirs:   bench/speed\r\n    default-language: GHC2021\r\n    build-depends:\r\n        base >=4.15 && <5,\r\n        criterion >=0.6.2.1 && <1.7,\r\n        deepseq >=1.3 && <1.6,\r\n        text >=0.2 && <2.2,\r\n        text-metrics\r\n\r\n    if flag(dev)\r\n        ghc-options:\r\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\r\n            -Wunused-packages\r\n\r\n    else\r\n        ghc-options: -O2 -Wall\r\n\r\nbenchmark bench-memory\r\n    type:             exitcode-stdio-1.0\r\n    main-is:          Main.hs\r\n    hs-source-dirs:   bench/memory\r\n    default-language: GHC2021\r\n    build-depends:\r\n        base >=4.15 && <5,\r\n        deepseq >=1.3 && <1.6,\r\n        text >=0.2 && <2.2,\r\n        text-metrics,\r\n        weigh >=0.0.4\r\n\r\n    if flag(dev)\r\n        ghc-options:\r\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\r\n            -Wunused-packages\r\n\r\n    else\r\n        ghc-options: -O2 -Wall\r\n";
  }
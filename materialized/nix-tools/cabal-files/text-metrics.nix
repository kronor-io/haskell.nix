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
    package-description-override = "cabal-version:   2.4\nname:            text-metrics\nversion:         0.3.3\nlicense:         BSD-3-Clause\nlicense-file:    LICENSE.md\nmaintainer:      Mark Karpov <markkarpov92@gmail.com>\nauthor:          Mark Karpov <markkarpov92@gmail.com>\ntested-with:     ghc ==9.6.3 ghc ==9.8.2 ghc ==9.10.1\nhomepage:        https://github.com/mrkkrp/text-metrics\nbug-reports:     https://github.com/mrkkrp/text-metrics/issues\nsynopsis:        Calculate various string metrics efficiently\ndescription:     Calculate various string metrics efficiently.\ncategory:        Text, Algorithms\nbuild-type:      Simple\nextra-doc-files:\n    CHANGELOG.md\n    README.md\n\nsource-repository head\n    type:     git\n    location: https://github.com/mrkkrp/text-metrics.git\n\nflag dev\n    description: Turn on development settings.\n    default:     False\n    manual:      True\n\nlibrary\n    exposed-modules:  Data.Text.Metrics\n    default-language: GHC2021\n    build-depends:\n        base >=4.15 && <5,\n        containers >=0.5 && <0.8,\n        text >=0.2 && <2.2,\n        vector >=0.11 && <0.14,\n        primitive >=0.9 && <0.10\n\n    if flag(dev)\n        ghc-options:\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\n            -Wunused-packages\n\n    else\n        ghc-options: -O2 -Wall\n\ntest-suite tests\n    type:             exitcode-stdio-1.0\n    main-is:          Main.hs\n    hs-source-dirs:   tests\n    default-language: GHC2021\n    build-depends:\n        QuickCheck >=2.8 && <3,\n        base >=4.15 && <5,\n        hspec >=2.0 && <3,\n        text >=0.2 && <2.2,\n        text-metrics\n\n    if flag(dev)\n        ghc-options:\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\n            -Wunused-packages\n\n    else\n        ghc-options: -O2 -Wall\n\nbenchmark bench-speed\n    type:             exitcode-stdio-1.0\n    main-is:          Main.hs\n    hs-source-dirs:   bench/speed\n    default-language: GHC2021\n    build-depends:\n        base >=4.15 && <5,\n        criterion >=0.6.2.1 && <1.7,\n        deepseq >=1.3 && <1.6,\n        text >=0.2 && <2.2,\n        text-metrics\n\n    if flag(dev)\n        ghc-options:\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\n            -Wunused-packages\n\n    else\n        ghc-options: -O2 -Wall\n\nbenchmark bench-memory\n    type:             exitcode-stdio-1.0\n    main-is:          Main.hs\n    hs-source-dirs:   bench/memory\n    default-language: GHC2021\n    build-depends:\n        base >=4.15 && <5,\n        deepseq >=1.3 && <1.6,\n        text >=0.2 && <2.2,\n        text-metrics,\n        weigh >=0.0.4\n\n    if flag(dev)\n        ghc-options:\n            -Wall -Werror -Wredundant-constraints -Wpartial-fields\n            -Wunused-packages\n\n    else\n        ghc-options: -O2 -Wall\n";
  }
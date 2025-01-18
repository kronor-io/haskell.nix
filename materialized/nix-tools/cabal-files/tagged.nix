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
    flags = { deepseq = true; transformers = true; };
    package = {
      specVersion = "1.10";
      identifier = { name = "tagged"; version = "0.8.9"; };
      license = "BSD-3-Clause";
      copyright = "2009-2015 Edward A. Kmett";
      maintainer = "Edward A. Kmett <ekmett@gmail.com>";
      author = "Edward A. Kmett";
      homepage = "http://github.com/ekmett/tagged";
      url = "";
      synopsis = "Haskell 98 phantom types to avoid unsafely passing dummy arguments";
      description = "Haskell 98 phantom types to avoid unsafely passing dummy arguments.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = ([
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
        ] ++ pkgs.lib.optional (flags.deepseq) (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))) ++ pkgs.lib.optional (flags.transformers) (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"));
        buildable = true;
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/tagged-0.8.9.tar.gz";
      sha256 = "6daad88ebb414ba6a556d2898d2cbe7650e4276010e3a6eed939daf54b956784";
    });
  }) // {
    package-description-override = "name:           tagged\nversion:        0.8.9\nlicense:        BSD3\nlicense-file:   LICENSE\nauthor:         Edward A. Kmett\nmaintainer:     Edward A. Kmett <ekmett@gmail.com>\nstability:      experimental\ncategory:       Data, Phantom Types\nsynopsis:       Haskell 98 phantom types to avoid unsafely passing dummy arguments\nhomepage:       http://github.com/ekmett/tagged\nbug-reports:    http://github.com/ekmett/tagged/issues\ncopyright:      2009-2015 Edward A. Kmett\ndescription:    Haskell 98 phantom types to avoid unsafely passing dummy arguments.\nbuild-type:     Simple\ncabal-version:  >= 1.10\nextra-source-files: .hlint.yaml CHANGELOG.markdown README.markdown\ntested-with:\n  GHC == 8.0.2\n  GHC == 8.2.2\n  GHC == 8.4.4\n  GHC == 8.6.5\n  GHC == 8.8.4\n  GHC == 8.10.7\n  GHC == 9.0.2\n  GHC == 9.2.8\n  GHC == 9.4.8\n  GHC == 9.6.6\n  GHC == 9.8.4\n  GHC == 9.10.1\n  GHC == 9.12.1\n\nsource-repository head\n  type: git\n  location: https://github.com/ekmett/tagged.git\n\nflag deepseq\n  description:\n    You can disable the use of the `deepseq` package using `-f-deepseq`.\n    .\n    Disabing this is an unsupported configuration, but it may be useful for accelerating builds in sandboxes for expert users.\n  default: True\n  manual: True\n\nflag transformers\n  description:\n    You can disable the use of the `transformers` and `transformers-compat` packages using `-f-transformers`.\n    .\n    Disable this is an unsupported configuration, but it may be useful for accelerating builds in sandboxes for expert users.\n  default: True\n  manual: True\n\nlibrary\n  default-language: Haskell98\n  other-extensions: CPP\n  build-depends:\n    base >= 4.9 && < 5,\n    template-haskell >= 2.11 && < 2.24\n  ghc-options: -Wall\n  hs-source-dirs: src\n  exposed-modules:\n    Data.Proxy.TH\n    Data.Tagged\n\n  if impl(ghc >= 9.0)\n    -- these flags may abort compilation with GHC-8.10\n    -- https://gitlab.haskell.org/ghc/ghc/-/merge_requests/3295\n    ghc-options: -Winferred-safe-imports -Wmissing-safe-haskell-mode\n\n  if flag(deepseq)\n    build-depends: deepseq >= 1.1 && < 1.6\n\n  if flag(transformers)\n    build-depends: transformers >= 0.4.2.0 && < 0.7\n";
  }
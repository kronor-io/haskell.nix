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
      identifier = { name = "lens-family-th"; version = "0.5.3.2"; };
      license = "BSD-3-Clause";
      copyright = "(c) Dan Burton 2012-2020";
      maintainer = "danburton.email@gmail.com";
      author = "Dan Burton";
      homepage = "http://github.com/DanBurton/lens-family-th#readme";
      url = "";
      synopsis = "Generate lens-family style lenses";
      description = "(see README.md)";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
        ];
        buildable = true;
      };
      tests = {
        "lens-family-th-test" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."hspec" or (errorHandler.buildDepError "hspec"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."lens-family-th" or (errorHandler.buildDepError "lens-family-th"))
            (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/lens-family-th-0.5.3.2.tar.gz";
      sha256 = "308f0ec402ebf93e65b225b0ac782c3ef73924f948a95e7969dd3e2a95cd7fd2";
    });
  }) // {
    package-description-override = "name:                lens-family-th\nversion:             0.5.3.2\nsynopsis:            Generate lens-family style lenses\n\ndescription:         (see README.md)\n\nlicense:             BSD3\nlicense-file:        LICENSE\nauthor:              Dan Burton\ncopyright:           (c) Dan Burton 2012-2020\n\nhomepage:            http://github.com/DanBurton/lens-family-th#readme\nbug-reports:         http://github.com/DanBurton/lens-family-th/issues\nmaintainer:          danburton.email@gmail.com\n\ncategory:            Data\nbuild-type:          Simple\ncabal-version:       >=1.10\n\nextra-source-files:  README.md, ChangeLog.md\n\ntested-with:         GHC == 9.12.2\n                   , GHC == 9.10.2\n                   , GHC == 9.8.4\n                   , GHC == 9.6.3\n                   , GHC == 9.4.8\n                   , GHC == 9.2.8\n                   , GHC == 9.0.2\n                   , GHC == 8.10.7\n                   , GHC == 8.8.4\n                   , GHC == 8.6.5\n                   , GHC == 8.4.4\n\nlibrary\n  default-language:  Haskell2010\n  hs-source-dirs:    src\n  exposed-modules:   Lens.Family.TH\n                   , Lens.Family2.TH\n                   , Lens.Family.THCore\n  build-depends:     base >= 4.9 && < 5\n                   , template-haskell >= 2.11 && < 2.24\n\ntest-suite lens-family-th-test\n  default-language:  Haskell2010\n  type:              exitcode-stdio-1.0\n  hs-source-dirs:    test\n  main-is:           Test.hs\n  build-depends:     base\n                   , hspec\n                   , transformers\n                   , lens-family-th\n                   , template-haskell\n\nsource-repository head\n  type:              git\n  location:          git://github.com/DanBurton/lens-family-th.git\n";
  }
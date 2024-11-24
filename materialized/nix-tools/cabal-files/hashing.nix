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
      identifier = { name = "hashing"; version = "0.1.0.0"; };
      license = "BSD-3-Clause";
      copyright = "2016 Baojun Wang";
      maintainer = "wangbj@gmail.com";
      author = "Baojun Wang";
      homepage = "https://github.com/wangbj/hashing/blob/master/README.md";
      url = "";
      synopsis = "Initial project template from stack";
      description = "Please see README.md";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
          (hsPkgs."array" or (errorHandler.buildDepError "array"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
        ];
        buildable = true;
      };
      exes = {
        "hashing-exe" = {
          depends = [
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."array" or (errorHandler.buildDepError "array"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."hashing" or (errorHandler.buildDepError "hashing"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          ];
          buildable = true;
        };
      };
      tests = {
        "hashing-test" = {
          depends = [
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."array" or (errorHandler.buildDepError "array"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."hashing" or (errorHandler.buildDepError "hashing"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
            (hsPkgs."cryptonite" or (errorHandler.buildDepError "cryptonite"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/hashing-0.1.0.0.tar.gz";
      sha256 = "2f1c97a3ca2acd05f9e961ed0d594521420c6a14b38568326689318265d38ac5";
    });
  }) // {
    package-description-override = "name:                hashing\nversion:             0.1.0.0\nsynopsis:            Initial project template from stack\ndescription:         Please see README.md\nhomepage:            https://github.com/wangbj/hashing/blob/master/README.md\nlicense:             BSD3\nlicense-file:        LICENSE\nauthor:              Baojun Wang\nmaintainer:          wangbj@gmail.com\ncopyright:           2016 Baojun Wang\ncategory:            Cryptography\nbuild-type:          Simple\n-- extra-source-files:\ncabal-version:       >=1.10\n\nlibrary\n  hs-source-dirs:      src\n  exposed-modules:     Crypto.Hash\n                     , Crypto.Hash.ADT\n                     , Crypto.Hash.SHA1\n                     , Crypto.Hash.SHA256\n                     , Crypto.Hash.SHA512\n                     , Crypto.Hash.MD5\n                     , Crypto.Hash.Whirlpool\n  build-depends:       QuickCheck >= 2.8.1\n                     , array >= 0.5.1.0\n                     , base >= 4.7 && < 5\n                     , bytestring >= 0.10.6.0\n                     , mtl >= 2.2.1\n                     , template-haskell >= 2.10.0.0\n  default-language:    Haskell2010\n\nexecutable hashing-exe\n  hs-source-dirs:      app\n  main-is:             Main.hs\n  ghc-options:         -threaded -rtsopts -Wall -with-rtsopts=-N1\n  build-depends:       QuickCheck >= 2.8.1\n                     , array >= 0.5.1.0\n                     , base\n                     , bytestring >= 0.10.6.0\n                     , hashing\n                     , mtl >= 2.2.1\n                     , template-haskell >= 2.10.0.0\n  default-language:    Haskell2010\n\ntest-suite hashing-test\n  type:                exitcode-stdio-1.0\n  hs-source-dirs:      test\n  main-is:             Spec.hs\n  build-depends:       QuickCheck >= 2.8.1\n                     , array >= 0.5.1.0\n                     , base\n                     , bytestring >= 0.10.6.0\n                     , hashing >= 0.1.0.0\n                     , mtl >= 2.2.1\n                     , template-haskell >= 2.10.0.0\n                     , cryptonite >= 0.15\n  ghc-options:         -threaded -rtsopts -with-rtsopts=-N1\n  default-language:    Haskell2010\n\nsource-repository head\n  type:     git\n  location: https://github.com/wangbj/hashing\n";
  }
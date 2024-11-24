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
      identifier = { name = "saltine"; version = "0.0.1.0"; };
      license = "MIT";
      copyright = "Copyright (c) Joseph Abrahamson 2013";
      maintainer = "Max Amanshauser <max@lambdalifting.org>";
      author = "Joseph Abrahamson";
      homepage = "";
      url = "";
      synopsis = "Cryptography that's easy to digest (NaCl/libsodium bindings).";
      description = "/NaCl/ (pronounced \\\"salt\\\") is a new easy-to-use high-speed software\nlibrary for network communication, encryption, decryption,\nsignatures, etc. NaCl's goal is to provide all of the core\noperations needed to build higher-level cryptographic tools.\n\n<http://nacl.cr.yp.to/>\n\n/Sodium/ is a portable, cross-compilable, installable, packageable\ncrypto library based on NaCl, with a compatible API.\n\n<https://github.com/jedisct1/libsodium>\n\n/Saltine/ is a Haskell binding to the NaCl primitives going through\nSodium for build convenience and, eventually, portability.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."profunctors" or (errorHandler.buildDepError "profunctors"))
        ];
        libs = [ (pkgs."sodium" or (errorHandler.sysDepError "sodium")) ];
        buildable = true;
      };
      tests = {
        "tests" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."saltine" or (errorHandler.buildDepError "saltine"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."test-framework-quickcheck2" or (errorHandler.buildDepError "test-framework-quickcheck2"))
            (hsPkgs."test-framework" or (errorHandler.buildDepError "test-framework"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/saltine-0.0.1.0.tar.gz";
      sha256 = "0fd8ff68fbb2b626771ff3ea58fb88d440b81f21c98ceb83fe1b9e72a0b24aef";
    });
  }) // {
    package-description-override = "name:                saltine\nversion:             0.0.1.0\nsynopsis:            Cryptography that's easy to digest (NaCl/libsodium bindings).\ndescription:\n\n  /NaCl/ (pronounced \\\"salt\\\") is a new easy-to-use high-speed software\n  library for network communication, encryption, decryption,\n  signatures, etc. NaCl's goal is to provide all of the core\n  operations needed to build higher-level cryptographic tools.\n  .\n  <http://nacl.cr.yp.to/>\n  .\n  /Sodium/ is a portable, cross-compilable, installable, packageable\n  crypto library based on NaCl, with a compatible API.\n  .\n  <https://github.com/jedisct1/libsodium>\n  .\n  /Saltine/ is a Haskell binding to the NaCl primitives going through\n  Sodium for build convenience and, eventually, portability.\n\nlicense:             MIT\nlicense-file:        LICENSE\nauthor:              Joseph Abrahamson\nmaintainer:          Max Amanshauser <max@lambdalifting.org>\nbug-reports:         http://github.com/tel/saltine/issues\ncopyright:           Copyright (c) Joseph Abrahamson 2013\ncategory:            Cryptography\nbuild-type:          Simple\ncabal-version:       >=1.10\ntested-with:         GHC==7.8.4, GHC==7.10.3, GHC==8.0.2\n\nsource-repository head\n  type: git\n  location: https://github.com/tel/saltine.git\n\nlibrary\n  hs-source-dirs:     src\n  exposed-modules:\n                  Crypto.Saltine\n                  Crypto.Saltine.Internal.ByteSizes\n                  Crypto.Saltine.Core.SecretBox\n                  Crypto.Saltine.Core.Box\n                  Crypto.Saltine.Core.Stream\n                  Crypto.Saltine.Core.Auth\n                  Crypto.Saltine.Core.OneTimeAuth\n                  Crypto.Saltine.Core.Sign\n                  Crypto.Saltine.Core.Hash\n                  Crypto.Saltine.Core.ScalarMult\n                  Crypto.Saltine.Class\n  other-modules:\n                Crypto.Saltine.Internal.Util\n  extra-libraries:    sodium\n  cc-options:         -Wall\n  ghc-options:        -Wall -funbox-strict-fields\n  default-language:   Haskell2010\n  build-depends:\n                base >= 4.5 && < 5\n              , bytestring\n              , profunctors\n\ntest-suite tests\n  type:    exitcode-stdio-1.0\n  main-is: Main.hs\n  other-modules:\n                AuthProperties\n                BoxProperties\n                OneTimeAuthProperties\n                ScalarMultProperties\n                SecretBoxProperties\n                SignProperties\n                StreamProperties\n                Util\n  ghc-options: -Wall -threaded -rtsopts\n  hs-source-dirs: tests\n  default-language: Haskell2010\n  build-depends:\n                base >= 4.5 && < 5\n              , saltine\n              , bytestring\n              , QuickCheck\n              , test-framework-quickcheck2\n              , test-framework\n";
  }
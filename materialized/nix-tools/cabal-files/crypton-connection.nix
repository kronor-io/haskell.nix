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
      identifier = { name = "crypton-connection"; version = "0.4.3"; };
      license = "BSD-3-Clause";
      copyright = "Vincent Hanquez <vincent@snarc.org>";
      maintainer = "Kazu Yamamoto <kazu@iij.ad.jp>";
      author = "Vincent Hanquez <vincent@snarc.org>";
      homepage = "https://github.com/kazu-yamamoto/crypton-connection";
      url = "";
      synopsis = "Simple and easy network connection API";
      description = "Simple network library for all your connection needs.\n\nFeatures: Really simple to use, SSL/TLS, SOCKS.\n\nThis library provides a very simple api to create sockets\nto a destination with the choice of SSL/TLS, and SOCKS.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."basement" or (errorHandler.buildDepError "basement"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."data-default" or (errorHandler.buildDepError "data-default"))
          (hsPkgs."network" or (errorHandler.buildDepError "network"))
          (hsPkgs."tls" or (errorHandler.buildDepError "tls"))
          (hsPkgs."socks" or (errorHandler.buildDepError "socks"))
          (hsPkgs."crypton-x509" or (errorHandler.buildDepError "crypton-x509"))
          (hsPkgs."crypton-x509-store" or (errorHandler.buildDepError "crypton-x509-store"))
          (hsPkgs."crypton-x509-system" or (errorHandler.buildDepError "crypton-x509-system"))
          (hsPkgs."crypton-x509-validation" or (errorHandler.buildDepError "crypton-x509-validation"))
        ];
        buildable = true;
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/crypton-connection-0.4.3.tar.gz";
      sha256 = "c98825ce395e6aed4550fefae7c8e7d6b5b4435f5ad57d12aad33fd356f82ae1";
    });
  }) // {
    package-description-override = "Name:                crypton-connection\nVersion:             0.4.3\nDescription:\n    Simple network library for all your connection needs.\n    .\n    Features: Really simple to use, SSL/TLS, SOCKS.\n    .\n    This library provides a very simple api to create sockets\n    to a destination with the choice of SSL/TLS, and SOCKS.\nLicense:             BSD3\nLicense-file:        LICENSE\nCopyright:           Vincent Hanquez <vincent@snarc.org>\nAuthor:              Vincent Hanquez <vincent@snarc.org>\nMaintainer:          Kazu Yamamoto <kazu@iij.ad.jp>\nSynopsis:            Simple and easy network connection API\nBuild-Type:          Simple\nCategory:            Network\nstability:           experimental\nCabal-Version:       >=1.10\nHomepage:            https://github.com/kazu-yamamoto/crypton-connection\nextra-source-files:  README.md\n                     CHANGELOG.md\n\nLibrary\n  Default-Language:  Haskell2010\n  Build-Depends:     base >= 3 && < 5\n                   , basement\n                   , bytestring\n                   , containers\n                   , data-default\n                   , network >= 2.6.3\n                   , tls >= 1.7 && < 2.2\n                   , socks >= 0.6\n                   , crypton-x509 >= 1.5\n                   , crypton-x509-store >= 1.5\n                   , crypton-x509-system >= 1.5\n                   , crypton-x509-validation >= 1.5\n  Exposed-modules:   Network.Connection\n                     Network.Connection.Internal\n  Other-modules:     Network.Connection.Types\n  ghc-options:       -Wall\n\nsource-repository head\n  type: git\n  location: https://github.com/kazu-yamamoto/crypton-connection\n";
  }
{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = {};
    package = {
      specVersion = "2.2";
      identifier = { name = "ghc-prim"; version = "0.13.1"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "libraries@haskell.org";
      author = "";
      homepage = "";
      url = "";
      synopsis = "GHC primitives";
      description = "This package used to contain the primitive types and operations supplied by\nGHC. They are now exported by the ghc-internal package and ghc-prim is\ndeprecated.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."ghc-internal" or (errorHandler.buildDepError "ghc-internal"))
        ];
        buildable = true;
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "https://kronor-io.github.io/kronor-haskell-packages/package/ghc-prim-0.13.1.tar.gz";
      sha256 = config.sha256;
    });
  }
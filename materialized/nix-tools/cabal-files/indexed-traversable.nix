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
      specVersion = "1.12";
      identifier = { name = "indexed-traversable"; version = "0.1.4"; };
      license = "BSD-2-Clause";
      copyright = "";
      maintainer = "Oleg Grenrus <oleg.grenrus@iki.fi>";
      author = "Edward Kmett";
      homepage = "";
      url = "";
      synopsis = "FunctorWithIndex, FoldableWithIndex, TraversableWithIndex";
      description = "This package provides three useful generalizations:\n\n@\nclass Functor f => FunctorWithIndex i f | f -> i where\n\\  imap :: (i -> a -> b) -> f a -> f b\n@\n\n@\nclass Foldable f => FoldableWithIndex i f | f -> i where\n\\  ifoldMap :: Monoid m => (i -> a -> m) -> f a -> m\n@\n\n@\nclass (FunctorWithIndex i t, FoldableWithIndex i t, Traversable t) => TraversableWithIndex i t | t -> i where\n\\  itraverse :: Applicative f => (i -> a -> f b) -> t a -> f (t b)\n@\n\nThis package contains instances for types in GHC boot libraries.\nFor some additional instances see [indexed-traversable-instances](https://hackage.haskell.org/package/indexed-traversable-instances).\n\nThe [keys](https://hackage.haskell.org/package/keys) package provides similar functionality,\nbut uses (associated) @TypeFamilies@ instead of @FunctionalDependencies@.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."array" or (errorHandler.buildDepError "array"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
        ] ++ pkgs.lib.optional (!(compiler.isGhc && compiler.version.ge "9.6")) (hsPkgs."foldable1-classes-compat" or (errorHandler.buildDepError "foldable1-classes-compat"));
        buildable = true;
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/indexed-traversable-0.1.4.tar.gz";
      sha256 = "58be09afdf3ad5a25c2aa0d2a7df80d602df09f4e76d3abf2b7cdb0e75d03b22";
    });
  }) // {
    package-description-override = "cabal-version:      1.12\nname:               indexed-traversable\nversion:            0.1.4\nx-revision:         1\nbuild-type:         Simple\nlicense:            BSD2\nlicense-file:       LICENSE\ncategory:           Data\nmaintainer:         Oleg Grenrus <oleg.grenrus@iki.fi>\nauthor:             Edward Kmett\nsynopsis:           FunctorWithIndex, FoldableWithIndex, TraversableWithIndex\ndescription:\n  This package provides three useful generalizations:\n  .\n  @\n  class Functor f => FunctorWithIndex i f | f -> i where\n  \\  imap :: (i -> a -> b) -> f a -> f b\n  @\n  .\n  @\n  class Foldable f => FoldableWithIndex i f | f -> i where\n  \\  ifoldMap :: Monoid m => (i -> a -> m) -> f a -> m\n  @\n  .\n  @\n  class (FunctorWithIndex i t, FoldableWithIndex i t, Traversable t) => TraversableWithIndex i t | t -> i where\n  \\  itraverse :: Applicative f => (i -> a -> f b) -> t a -> f (t b)\n  @\n  .\n  This package contains instances for types in GHC boot libraries.\n  For some additional instances see [indexed-traversable-instances](https://hackage.haskell.org/package/indexed-traversable-instances).\n  .\n  The [keys](https://hackage.haskell.org/package/keys) package provides similar functionality,\n  but uses (associated) @TypeFamilies@ instead of @FunctionalDependencies@.\n\nextra-source-files: Changelog.md\ntested-with:\n  GHC ==8.6.5\n   || ==8.8.4\n   || ==8.10.7\n   || ==9.0.2\n   || ==9.2.8\n   || ==9.4.8\n   || ==9.6.6\n   || ==9.8.4\n   || ==9.10.1\n   || ==9.12.1\n\nsource-repository head\n  type:     git\n  location: https://github.com/haskellari/indexed-traversable\n  subdir:   indexed-traversable\n\nlibrary\n  default-language: Haskell2010\n  hs-source-dirs:   src\n  other-modules:\n    CoerceCompat\n    GhcList\n    WithIndex\n\n  exposed-modules:\n    Data.Foldable.WithIndex\n    Data.Foldable1.WithIndex\n    Data.Functor.WithIndex\n    Data.Traversable.WithIndex\n\n  build-depends:\n      array         >=0.3.0.2 && <0.6\n    , base          >=4.12    && <4.22\n    , containers    >=0.6.0.1 && <0.8\n    , transformers  >=0.5.6.0 && <0.7\n\n  if !impl(ghc >=9.6)\n    build-depends: foldable1-classes-compat >=0.1 && <0.2\n";
  }
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
    flags = { os-string = true; };
    package = {
      specVersion = "3.0";
      identifier = { name = "directory-ospath-streaming"; version = "0.2.1"; };
      license = "Apache-2.0";
      copyright = "(c) Sergey Vinokurov 2023";
      maintainer = "Sergey Vinokurov <serg.foo@gmail.com>";
      author = "Sergey Vinokurov";
      homepage = "https://github.com/sergv/directory-ospath-streaming";
      url = "";
      synopsis = "Stream directory entries in constant memory in vanilla IO";
      description = "Reading of directory contents in constant memory, i.e. in an iterative\nfashion without storing all directory elements in memory. From another\nperspective, this reading interface allows stopping at any point\nwithout loading every directory element.\n\nAlso defines general-purpose recursive directory traversals.\n\nBoth Windows and Unix systems are supported.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = ([
          (hsPkgs."atomic-counter" or (errorHandler.buildDepError "atomic-counter"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
        ] ++ (if flags.os-string
          then [
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."os-string" or (errorHandler.buildDepError "os-string"))
          ]
          else [
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
          ])) ++ (if system.isWindows
          then [
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."Win32" or (errorHandler.buildDepError "Win32"))
          ]
          else [ (hsPkgs."unix" or (errorHandler.buildDepError "unix")) ]);
        buildable = true;
      };
      tests = {
        "test" = {
          depends = ([
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."directory-ospath-streaming" or (errorHandler.buildDepError "directory-ospath-streaming"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
          ] ++ (if flags.os-string
            then [
              (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
              (hsPkgs."os-string" or (errorHandler.buildDepError "os-string"))
            ]
            else [
              (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            ])) ++ pkgs.lib.optionals (!system.isWindows) [
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."random" or (errorHandler.buildDepError "random"))
            (hsPkgs."unix" or (errorHandler.buildDepError "unix"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/directory-ospath-streaming-0.2.1.tar.gz";
      sha256 = "45c56130594256f3bb0f77743804b4f6cf949a7ad19694fdd8a46047ea185706";
    });
  }) // {
    package-description-override = "cabal-version: 3.0\n\n-- Created : 27 April 2023\n\nname:\n  directory-ospath-streaming\nversion:\n  0.2.1\nsynopsis:\n  Stream directory entries in constant memory in vanilla IO\ndescription:\n  Reading of directory contents in constant memory, i.e. in an iterative\n  fashion without storing all directory elements in memory. From another\n  perspective, this reading interface allows stopping at any point\n  without loading every directory element.\n\n  Also defines general-purpose recursive directory traversals.\n\n  Both Windows and Unix systems are supported.\ncopyright:\n  (c) Sergey Vinokurov 2023\nlicense:\n  Apache-2.0\nlicense-file:\n  LICENSE\nauthor:\n  Sergey Vinokurov\nmaintainer:\n  Sergey Vinokurov <serg.foo@gmail.com>\ncategory:\n  File, Streaming\n\ntested-with:\n  , GHC == 8.6\n  , GHC == 8.8\n  , GHC == 8.10\n  , GHC == 9.2\n  , GHC == 9.4\n  , GHC == 9.6\n  , GHC == 9.8\n  , GHC == 9.10\n\nbuild-type:\n  Simple\n\nextra-source-files:\n  test/filesystem/*.txt\n  test/filesystem/bin/*.txt\n\nextra-doc-files:\n  Changelog.md\n  Readme.md\n\nhomepage:\n  https://github.com/sergv/directory-ospath-streaming\n\nsource-repository head\n  type: git\n  location: https://github.com/sergv/directory-ospath-streaming.git\n\n-- Cabal will pick this flag up automatically during solving. Default to true\n-- since that’s what should be picked up for all future filepath versions starting at 1.5.\nflag os-string\n  description:\n    Depend on os-string package, needed for filepath >= 1.5\n  default:\n    True\n  manual:\n    False\n\ncommon ghc-options\n  default-language: Haskell2010\n\n  ghc-options:\n    -Weverything\n    -Wno-all-missed-specialisations\n    -Wno-implicit-prelude\n    -Wno-missed-specialisations\n    -Wno-missing-import-lists\n    -Wno-missing-local-signatures\n    -Wno-safe\n    -Wno-unsafe\n\n  if impl(ghc >= 8.8)\n    ghc-options:\n      -Wno-missing-deriving-strategies\n\n  if impl(ghc >= 8.10)\n    ghc-options:\n      -Wno-missing-safe-haskell-mode\n      -Wno-prepositive-qualified-module\n\n  if impl(ghc >= 9.2)\n    ghc-options:\n      -Wno-missing-kind-signatures\n\n  if impl(ghc >= 9.8)\n    ghc-options:\n      -Wno-missing-role-annotations\n      -Wno-missing-poly-kind-signatures\n\ncommon depends-on-filepath\n  if flag(os-string)\n    build-depends:\n      , filepath >= 1.5\n      , os-string >= 2.0\n  else\n    build-depends:\n      , filepath >= 1.4.100 && < 1.5\n\nlibrary\n  import: ghc-options, depends-on-filepath\n  exposed-modules:\n    System.Directory.OsPath.Streaming\n    System.Directory.OsPath.Streaming.Internal\n    System.Directory.OsPath.Streaming.Internal.Raw\n    System.Directory.OsPath.Types\n  other-modules:\n    System.Directory.OsPath.Contents\n    System.Directory.OsPath.FileType\n    System.Directory.OsPath.Utils\n  hs-source-dirs:\n    src\n  build-depends:\n    , atomic-counter\n    , base >= 4.12 && < 5\n    , deepseq >= 1.4\n\n  if os(windows)\n    build-depends:\n      , directory >= 1.3.8\n      , Win32 >= 2.13.3\n  else\n    build-depends:\n      -- Cannot use lower version because it doesn’t support OsStrings\n      , unix >= 2.8\n\ntest-suite test\n  import: ghc-options, depends-on-filepath\n  type:\n    exitcode-stdio-1.0\n  main-is:\n    test/TestMain.hs\n  hs-source-dirs:\n    .\n    test\n  build-depends:\n    , base >= 4.12\n    , directory-ospath-streaming\n    , tasty\n    , tasty-hunit\n  if !os(windows)\n    build-depends:\n      , directory\n      , random\n      , unix >= 2.8\n  ghc-options:\n    -rtsopts\n    -main-is TestMain\n";
  }
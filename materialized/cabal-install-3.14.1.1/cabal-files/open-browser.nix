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
      identifier = { name = "open-browser"; version = "0.2.1.0"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "rightfold@gmail.com";
      author = "rightfold";
      homepage = "https://github.com/rightfold/open-browser";
      url = "";
      synopsis = "Open a web browser from Haskell.";
      description = "Open a web browser from Haskell.\nCurrently BSD, Linux, OS X and Windows are supported.";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."process" or (errorHandler.buildDepError "process"))
        ] ++ pkgs.lib.optional (system.isWindows) (hsPkgs."Win32" or (errorHandler.buildDepError "Win32"));
        buildable = true;
      };
      exes = {
        "example" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."open-browser" or (errorHandler.buildDepError "open-browser"))
          ];
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/open-browser-0.2.1.0.tar.gz";
      sha256 = "0bed2e63800f738e78a4803ed22902accb50ac02068b96c17ce83a267244ca66";
    });
  }) // {
    package-description-override = "name:                       open-browser\nversion:                    0.2.1.0\nsynopsis:                   Open a web browser from Haskell.\ndescription:                Open a web browser from Haskell.\n                            Currently BSD, Linux, OS X and Windows are supported.\nlicense:                    BSD3\nlicense-file:               LICENSE\nauthor:                     rightfold\nhomepage: https://github.com/rightfold/open-browser\nmaintainer:                 rightfold@gmail.com\nbug-reports:                https://github.com/rightfold/open-browser/issues\ncategory:                   Web\nbuild-type:                 Simple\ncabal-version:              >=1.10\n\ntested-with: GHC >= 7.6\n\nsource-repository head\n    type:                   git\n    location:               https://github.com/rightfold/open-browser.git\n\nlibrary\n    exposed-modules:        Web.Browser\n    other-modules:          Web.Browser.Linux,\n                            Web.Browser.OSX\n    hs-source-dirs:         lib\n    default-language:       Haskell2010\n    build-depends:          base >= 4 && < 5, process >= 1 && < 2\n    if os(windows)\n      build-depends:        Win32\n      other-modules:        Web.Browser.Windows\n      if arch(i386)\n        cpp-options:        \"-DWINDOWS_CCONV=stdcall\"\n      else\n        cpp-options:        \"-DWINDOWS_CCONV=ccall\"\n\nexecutable example\n    main-is:                Main.hs\n    hs-source-dirs:         example\n    default-language:       Haskell2010\n    build-depends:          base >= 4 && < 5, open-browser\n";
  }
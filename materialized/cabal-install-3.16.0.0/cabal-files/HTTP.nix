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
    flags = {
      warn-as-error = false;
      conduit10 = false;
      warp-tests = false;
      network-uri = true;
    };
    package = {
      specVersion = "1.10";
      identifier = { name = "HTTP"; version = "4000.4.1"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "Ganesh Sittampalam <ganesh@earth.li>";
      author = "Warrick Gray <warrick.gray@hotmail.com>";
      homepage = "https://github.com/haskell/HTTP";
      url = "";
      synopsis = "A library for client-side HTTP";
      description = "The HTTP package supports client-side web programming in Haskell. It lets you set up\nHTTP connections, transmitting requests and processing the responses coming back, all\nfrom within the comforts of Haskell. It's dependent on the network package to operate,\nbut other than that, the implementation is all written in Haskell.\n\nA basic API for issuing single HTTP requests + receiving responses is provided. On top\nof that, a session-level abstraction is also on offer  (the @BrowserAction@ monad);\nit taking care of handling the management of persistent connections, proxies,\nstate (cookies) and authentication credentials required to handle multi-step\ninteractions with a web server.\n\nThe representation of the bytes flowing across is extensible via the use of a type class,\nletting you pick the representation of requests and responses that best fits your use.\nSome pre-packaged, common instances are provided for you (@ByteString@, @String@).\n\nHere's an example use:\n\n>\n>    do\n>      rsp <- Network.HTTP.simpleHTTP (getRequest \"http://www.haskell.org/\")\n>              -- fetch document and return it (as a 'String'.)\n>      fmap (take 100) (getResponseBody rsp)\n>\n>    do\n>      (_, rsp)\n>         <- Network.Browser.browse $ do\n>               setAllowRedirects True -- handle HTTP redirects\n>               request $ getRequest \"http://www.haskell.org/\"\n>      return (take 100 (rspBody rsp))\n\n__Note:__ This package does not support HTTPS connections.\nIf you need HTTPS, take a look at the following packages:\n\n* <http://hackage.haskell.org/package/http-streams http-streams>\n\n* <http://hackage.haskell.org/package/http-client http-client> (in combination with\n<http://hackage.haskell.org/package/http-client-tls http-client-tls>)\n\n* <http://hackage.haskell.org/package/req req>\n\n* <http://hackage.haskell.org/package/wreq wreq>\n";
      buildType = "Simple";
    };
    components = {
      "library" = {
        depends = ([
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."array" or (errorHandler.buildDepError "array"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."parsec" or (errorHandler.buildDepError "parsec"))
          (hsPkgs."time" or (errorHandler.buildDepError "time"))
          (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
          (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
          (hsPkgs."network" or (errorHandler.buildDepError "network"))
        ] ++ (if flags.network-uri
          then [
            (hsPkgs."network-uri" or (errorHandler.buildDepError "network-uri"))
            (hsPkgs."network" or (errorHandler.buildDepError "network"))
          ]
          else [
            (hsPkgs."network" or (errorHandler.buildDepError "network"))
          ])) ++ pkgs.lib.optional (system.isWindows) (hsPkgs."Win32" or (errorHandler.buildDepError "Win32"));
        buildable = true;
      };
      tests = {
        "test" = {
          depends = ([
            (hsPkgs."HTTP" or (errorHandler.buildDepError "HTTP"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."network" or (errorHandler.buildDepError "network"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."httpd-shed" or (errorHandler.buildDepError "httpd-shed"))
            (hsPkgs."HUnit" or (errorHandler.buildDepError "HUnit"))
            (hsPkgs."pureMD5" or (errorHandler.buildDepError "pureMD5"))
            (hsPkgs."split" or (errorHandler.buildDepError "split"))
            (hsPkgs."test-framework" or (errorHandler.buildDepError "test-framework"))
            (hsPkgs."test-framework-hunit" or (errorHandler.buildDepError "test-framework-hunit"))
          ] ++ (if flags.network-uri
            then [
              (hsPkgs."network-uri" or (errorHandler.buildDepError "network-uri"))
              (hsPkgs."network" or (errorHandler.buildDepError "network"))
            ]
            else [
              (hsPkgs."network" or (errorHandler.buildDepError "network"))
            ])) ++ pkgs.lib.optionals (flags.warp-tests) ([
            (hsPkgs."case-insensitive" or (errorHandler.buildDepError "case-insensitive"))
            (hsPkgs."conduit" or (errorHandler.buildDepError "conduit"))
            (hsPkgs."http-types" or (errorHandler.buildDepError "http-types"))
            (hsPkgs."wai" or (errorHandler.buildDepError "wai"))
            (hsPkgs."warp" or (errorHandler.buildDepError "warp"))
          ] ++ (if flags.conduit10
            then [
              (hsPkgs."conduit" or (errorHandler.buildDepError "conduit"))
            ]
            else [
              (hsPkgs."conduit" or (errorHandler.buildDepError "conduit"))
              (hsPkgs."conduit-extra" or (errorHandler.buildDepError "conduit-extra"))
            ]));
          buildable = true;
        };
      };
    };
  } // {
    src = pkgs.lib.mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/HTTP-4000.4.1.tar.gz";
      sha256 = "df31d8efec775124dab856d7177ddcba31be9f9e0836ebdab03d94392f2dd453";
    });
  }) // {
    package-description-override = "Cabal-Version: >= 1.10\r\nName: HTTP\r\nVersion: 4000.4.1\r\nx-revision: 6\r\nBuild-type: Simple\r\nLicense: BSD3\r\nLicense-file: LICENSE\r\nAuthor: Warrick Gray <warrick.gray@hotmail.com>\r\nMaintainer: Ganesh Sittampalam <ganesh@earth.li>\r\nHomepage: https://github.com/haskell/HTTP\r\nCategory: Network\r\nSynopsis: A library for client-side HTTP\r\nDescription:\r\n\r\n The HTTP package supports client-side web programming in Haskell. It lets you set up\r\n HTTP connections, transmitting requests and processing the responses coming back, all\r\n from within the comforts of Haskell. It's dependent on the network package to operate,\r\n but other than that, the implementation is all written in Haskell.\r\n .\r\n A basic API for issuing single HTTP requests + receiving responses is provided. On top\r\n of that, a session-level abstraction is also on offer  (the @BrowserAction@ monad);\r\n it taking care of handling the management of persistent connections, proxies,\r\n state (cookies) and authentication credentials required to handle multi-step\r\n interactions with a web server.\r\n .\r\n The representation of the bytes flowing across is extensible via the use of a type class,\r\n letting you pick the representation of requests and responses that best fits your use.\r\n Some pre-packaged, common instances are provided for you (@ByteString@, @String@).\r\n .\r\n Here's an example use:\r\n .\r\n >\r\n >    do\r\n >      rsp <- Network.HTTP.simpleHTTP (getRequest \"http://www.haskell.org/\")\r\n >              -- fetch document and return it (as a 'String'.)\r\n >      fmap (take 100) (getResponseBody rsp)\r\n >\r\n >    do\r\n >      (_, rsp)\r\n >         <- Network.Browser.browse $ do\r\n >               setAllowRedirects True -- handle HTTP redirects\r\n >               request $ getRequest \"http://www.haskell.org/\"\r\n >      return (take 100 (rspBody rsp))\r\n .\r\n __Note:__ This package does not support HTTPS connections.\r\n If you need HTTPS, take a look at the following packages:\r\n .\r\n * <http://hackage.haskell.org/package/http-streams http-streams>\r\n .\r\n * <http://hackage.haskell.org/package/http-client http-client> (in combination with\r\n <http://hackage.haskell.org/package/http-client-tls http-client-tls>)\r\n .\r\n * <http://hackage.haskell.org/package/req req>\r\n .\r\n * <http://hackage.haskell.org/package/wreq wreq>\r\n .\r\n\r\nExtra-Source-Files: CHANGES\r\n\r\ntested-with:\r\n  GHC == 9.12.1\r\n  GHC == 9.10.1\r\n  GHC == 9.8.4\r\n  GHC == 9.6.6\r\n  GHC == 9.4.8\r\n  GHC == 9.2.8\r\n  GHC == 9.0.2\r\n  GHC == 8.10.7\r\n  GHC == 8.8.4\r\n  GHC == 8.6.5\r\n  GHC == 8.4.4\r\n  GHC == 8.2.2\r\n  -- CI failing for GHC 8.0 because of https://github.com/haskell/cabal/issues/10379\r\n  -- GHC == 8.0.2\r\n\r\nSource-Repository head\r\n  type: git\r\n  location: https://github.com/haskell/HTTP.git\r\n\r\nFlag warn-as-error\r\n  default:     False\r\n  description: Build with warnings-as-errors\r\n  manual:      True\r\n\r\nFlag conduit10\r\n  description: Use version 1.0.x or below of the conduit package (for the test suite)\r\n  default: False\r\n\r\nFlag warp-tests\r\n  description: Test against warp\r\n  default:     False\r\n  manual:      True\r\n\r\nflag network-uri\r\n  description: Get Network.URI from the network-uri package\r\n  default: True\r\n\r\nLibrary\r\n  Exposed-modules:\r\n                 Network.BufferType,\r\n                 Network.Stream,\r\n                 Network.StreamDebugger,\r\n                 Network.StreamSocket,\r\n                 Network.TCP,\r\n                 Network.HTTP,\r\n                 Network.HTTP.Headers,\r\n                 Network.HTTP.Base,\r\n                 Network.HTTP.Stream,\r\n                 Network.HTTP.Auth,\r\n                 Network.HTTP.Cookie,\r\n                 Network.HTTP.Proxy,\r\n                 Network.HTTP.HandleStream,\r\n                 Network.Browser\r\n  Other-modules:\r\n                 Network.HTTP.Base64,\r\n                 Network.HTTP.MD5Aux,\r\n                 Network.HTTP.Utils\r\n                 Paths_HTTP\r\n  GHC-options: -fwarn-missing-signatures -Wall\r\n\r\n  -- note the test harness constraints should be kept in sync with these\r\n  -- where dependencies are shared\r\n  build-depends:\r\n      base          >= 4.6.0.0   && < 4.22\r\n    , array         >= 0.3.0.2   && < 0.6\r\n    , bytestring    >= 0.9.1.5   && < 0.13\r\n    , parsec        >= 2.0       && < 3.2\r\n    , time          >= 1.1.2.3   && < 1.15\r\n    , transformers  >= 0.2.0.0   && < 0.7\r\n        -- transformers-0.2.0.0 is the first to have Control.Monad.IO.Class\r\n    -- The following dependencies are refined by flags, but they should\r\n    -- still be mentioned here on the top-level.\r\n    , mtl           >= 2.0.0.0   && < 2.4\r\n    , network       >= 2.4       && < 3.3\r\n\r\n  default-language: Haskell98\r\n  default-extensions: FlexibleInstances\r\n\r\n  if flag(network-uri)\r\n    Build-depends: network-uri == 2.6.*, network >= 2.6\r\n  else\r\n    Build-depends: network < 2.6\r\n\r\n  if flag(warn-as-error)\r\n    ghc-options:      -Werror\r\n\r\n  if os(windows)\r\n    Build-depends: Win32 >= 2.2.0.0 && < 2.15\r\n\r\nTest-Suite test\r\n  type: exitcode-stdio-1.0\r\n\r\n  default-language: Haskell98\r\n  hs-source-dirs: test\r\n  main-is: httpTests.hs\r\n\r\n  other-modules:\r\n    Httpd\r\n    UnitTests\r\n\r\n  ghc-options: -Wall\r\n\r\n  build-depends:\r\n      HTTP\r\n    -- constraints inherited from HTTP\r\n    , base\r\n    , bytestring\r\n    , mtl\r\n    , network\r\n    -- extra dependencies\r\n    , deepseq               >= 1.3.0.0  && < 1.6\r\n    , httpd-shed            >= 0.4      && < 0.5\r\n    , HUnit                 >= 1.2.0.1  && < 1.7\r\n    , pureMD5               >= 0.2.4    && < 2.2\r\n    , split                 >= 0.1.3    && < 0.3\r\n    , test-framework        >= 0.2.0    && < 0.9\r\n    , test-framework-hunit  >= 0.3.0    && < 0.4\r\n\r\n  if flag(network-uri)\r\n    Build-depends: network-uri == 2.6.*, network >= 2.6\r\n  else\r\n    Build-depends: network < 2.6\r\n\r\n  if flag(warp-tests)\r\n    CPP-Options: -DWARP_TESTS\r\n    build-depends:\r\n        case-insensitive    >= 0.4.0.1  && < 1.3\r\n      , conduit             >= 1.0.8    && < 1.4\r\n      , http-types          >= 0.8.0    && < 1.0\r\n      , wai                 >= 2.1.0    && < 3.3\r\n      , warp                >= 2.1.0    && < 3.4\r\n\r\n    if flag(conduit10)\r\n      build-depends: conduit < 1.1\r\n    else\r\n      build-depends: conduit >= 1.1, conduit-extra >= 1.1 && < 1.4\r\n";
  }
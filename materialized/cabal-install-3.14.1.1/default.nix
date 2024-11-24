{
  pkgs = hackage:
    {
      packages = {
        base16-bytestring.revision = import ./cabal-files/base16-bytestring.nix;
        ed25519.revision = import ./cabal-files/ed25519.nix;
        ed25519.flags.test-properties = true;
        ed25519.flags.test-hlint = true;
        filepath.revision = hackage.filepath."1.5.4.0".revisions.default;
        semaphore-compat.revision = hackage.semaphore-compat."1.0.0".revisions.default;
        base64-bytestring.revision = import ./cabal-files/base64-bytestring.nix;
        lukko.revision = import ./cabal-files/lukko.nix;
        lukko.flags.ofd-locking = true;
        HTTP.revision = import ./cabal-files/HTTP.nix;
        HTTP.flags.network-uri = true;
        HTTP.flags.warp-tests = false;
        HTTP.flags.conduit10 = false;
        HTTP.flags.warn-as-error = false;
        resolv.revision = import ./cabal-files/resolv.nix;
        ghc-bignum.revision = hackage.ghc-bignum."1.3".revisions.default;
        stm.revision = hackage.stm."2.5.3.1".revisions.default;
        echo.revision = import ./cabal-files/echo.nix;
        echo.flags.example = false;
        transformers.revision = hackage.transformers."0.6.1.2".revisions.default;
        deepseq.revision = hackage.deepseq."1.5.1.0".revisions.default;
        open-browser.revision = import ./cabal-files/open-browser.nix;
        directory.revision = hackage.directory."1.3.9.0".revisions.default;
        file-io.revision = hackage.file-io."0.1.5".revisions.default;
        cryptohash-sha256.revision = import ./cabal-files/cryptohash-sha256.nix;
        cryptohash-sha256.flags.exe = false;
        cryptohash-sha256.flags.use-cbits = true;
        parsec.revision = hackage.parsec."3.1.17.0".revisions.default;
        Cabal.revision = hackage.Cabal."3.14.1.0".revisions.default;
        mtl.revision = hackage.mtl."2.3.1".revisions.default;
        process.revision = hackage.process."1.6.25.0".revisions.default;
        atomic-counter.revision = import ./cabal-files/atomic-counter.nix;
        atomic-counter.flags.dev = false;
        atomic-counter.flags.no-cmm = false;
        base.revision = hackage.base."4.21.0.0".revisions.default;
        Cabal-syntax.revision = hackage.Cabal-syntax."3.14.1.0".revisions.default;
        network-uri.revision = import ./cabal-files/network-uri.nix;
        random.revision = import ./cabal-files/random.nix;
        async.revision = import ./cabal-files/async.nix;
        async.flags.bench = false;
        cabal-install-solver.revision = import ./cabal-files/cabal-install-solver.nix;
        cabal-install-solver.flags.debug-tracetree = false;
        cabal-install-solver.flags.debug-expensive-assertions = false;
        text.revision = hackage.text."2.1.2".revisions.default;
        safe-exceptions.revision = import ./cabal-files/safe-exceptions.nix;
        time.revision = hackage.time."1.14".revisions.default;
        array.revision = hackage.array."0.5.8.0".revisions.default;
        regex-posix.revision = import ./cabal-files/regex-posix.nix;
        regex-posix.flags._regex-posix-clib = false;
        tar.revision = import ./cabal-files/tar.nix;
        network.revision = import ./cabal-files/network.nix;
        network.flags.devel = false;
        hashable.revision = import ./cabal-files/hashable.nix;
        hashable.flags.random-initial-seed = false;
        hashable.flags.arch-native = false;
        th-compat.revision = import ./cabal-files/th-compat.nix;
        ghc-internal.revision = hackage.ghc-internal."9.1201.0".revisions.default;
        binary.revision = hackage.binary."0.8.9.2".revisions.default;
        directory-ospath-streaming.revision = import ./cabal-files/directory-ospath-streaming.nix;
        directory-ospath-streaming.flags.os-string = true;
        template-haskell.revision = hackage.template-haskell."2.23.0.0".revisions.default;
        unix.revision = hackage.unix."2.8.6.0".revisions.default;
        hsc2hs.revision = import ./cabal-files/hsc2hs.nix;
        hsc2hs.flags.in-ghc-tree = false;
        exceptions.revision = hackage.exceptions."0.10.9".revisions.default;
        bytestring.revision = hackage.bytestring."0.12.2.0".revisions.default;
        regex-base.revision = import ./cabal-files/regex-base.nix;
        ghc-boot-th.revision = hackage.ghc-boot-th."9.12.1".revisions.default;
        os-string.revision = hackage.os-string."2.0.7".revisions.default;
        ghc-prim.revision = hackage.ghc-prim."0.13.0".revisions.default;
        pretty.revision = hackage.pretty."1.1.3.6".revisions.default;
        hackage-security.revision = import ./cabal-files/hackage-security.nix;
        hackage-security.flags.lukko = true;
        hackage-security.flags.cabal-syntax = true;
        zlib.revision = import ./cabal-files/zlib.nix;
        zlib.flags.bundled-c-zlib = false;
        zlib.flags.non-blocking-ffi = true;
        zlib.flags.pkg-config = true;
        splitmix.revision = import ./cabal-files/splitmix.nix;
        splitmix.flags.optimised-mixer = false;
        edit-distance.revision = import ./cabal-files/edit-distance.nix;
        containers.revision = hackage.containers."0.7".revisions.default;
        rts.revision = hackage.rts."1.0.2".revisions.default;
      };
      compiler = {
        version = "9.12.1";
        nix-name = "ghc9121";
        packages = {
          "ghc-boot-th" = "9.12.1";
          "binary" = "0.8.9.2";
          "pretty" = "1.1.3.6";
          "array" = "0.5.8.0";
          "time" = "1.14";
          "file-io" = "0.1.5";
          "ghc-prim" = "0.13.0";
          "bytestring" = "0.12.2.0";
          "process" = "1.6.25.0";
          "mtl" = "2.3.1";
          "text" = "2.1.2";
          "template-haskell" = "2.23.0.0";
          "semaphore-compat" = "1.0.0";
          "parsec" = "3.1.17.0";
          "ghc-bignum" = "1.3";
          "stm" = "2.5.3.1";
          "Cabal" = "3.14.1.0";
          "filepath" = "1.5.4.0";
          "os-string" = "2.0.7";
          "rts" = "1.0.2";
          "unix" = "2.8.6.0";
          "exceptions" = "0.10.9";
          "deepseq" = "1.5.1.0";
          "Cabal-syntax" = "3.14.1.0";
          "transformers" = "0.6.1.2";
          "containers" = "0.7";
          "ghc-internal" = "9.1201.0";
          "base" = "4.21.0.0";
          "directory" = "1.3.9.0";
        };
      };
    };
  extras = hackage:
    { packages = { cabal-install = ./.plan.nix/cabal-install.nix; }; };
  modules = [
    {
      preExistingPkgs = [
        "filepath"
        "semaphore-compat"
        "ghc-bignum"
        "stm"
        "transformers"
        "deepseq"
        "directory"
        "file-io"
        "parsec"
        "Cabal"
        "mtl"
        "process"
        "base"
        "Cabal-syntax"
        "text"
        "time"
        "array"
        "ghc-internal"
        "binary"
        "template-haskell"
        "unix"
        "exceptions"
        "bytestring"
        "ghc-boot-th"
        "os-string"
        "ghc-prim"
        "pretty"
        "containers"
        "rts"
      ];
    }
    ({ lib, ... }:
      {
        packages = {
          "cabal-install" = {
            flags = {
              "lukko" = lib.mkOverride 900 true;
              "native-dns" = lib.mkOverride 900 true;
            };
          };
        };
      })
    ({ lib, ... }:
      {
        packages = {
          "Cabal-syntax".components.library.planned = lib.mkOverride 900 true;
          "semaphore-compat".components.library.planned = lib.mkOverride 900 true;
          "base64-bytestring".components.library.planned = lib.mkOverride 900 true;
          "file-io".components.library.planned = lib.mkOverride 900 true;
          "hashable".components.library.planned = lib.mkOverride 900 true;
          "template-haskell".components.library.planned = lib.mkOverride 900 true;
          "network-uri".components.library.planned = lib.mkOverride 900 true;
          "transformers".components.library.planned = lib.mkOverride 900 true;
          "array".components.library.planned = lib.mkOverride 900 true;
          "unix".components.library.planned = lib.mkOverride 900 true;
          "exceptions".components.library.planned = lib.mkOverride 900 true;
          "cryptohash-sha256".components.library.planned = lib.mkOverride 900 true;
          "directory".components.library.planned = lib.mkOverride 900 true;
          "echo".components.library.planned = lib.mkOverride 900 true;
          "ed25519".components.library.planned = lib.mkOverride 900 true;
          "containers".components.library.planned = lib.mkOverride 900 true;
          "lukko".components.library.planned = lib.mkOverride 900 true;
          "HTTP".components.library.planned = lib.mkOverride 900 true;
          "parsec".components.library.planned = lib.mkOverride 900 true;
          "random".components.library.planned = lib.mkOverride 900 true;
          "cabal-install".components.library.planned = lib.mkOverride 900 true;
          "open-browser".components.library.planned = lib.mkOverride 900 true;
          "resolv".components.library.planned = lib.mkOverride 900 true;
          "Cabal".components.library.planned = lib.mkOverride 900 true;
          "cabal-install-solver".components.library.planned = lib.mkOverride 900 true;
          "safe-exceptions".components.library.planned = lib.mkOverride 900 true;
          "stm".components.library.planned = lib.mkOverride 900 true;
          "rts".components.library.planned = lib.mkOverride 900 true;
          "tar".components.library.planned = lib.mkOverride 900 true;
          "network".components.library.planned = lib.mkOverride 900 true;
          "bytestring".components.library.planned = lib.mkOverride 900 true;
          "tar".components.sublibs."tar-internal".planned = lib.mkOverride 900 true;
          "deepseq".components.library.planned = lib.mkOverride 900 true;
          "zlib".components.library.planned = lib.mkOverride 900 true;
          "filepath".components.library.planned = lib.mkOverride 900 true;
          "edit-distance".components.library.planned = lib.mkOverride 900 true;
          "regex-base".components.library.planned = lib.mkOverride 900 true;
          "regex-posix".components.library.planned = lib.mkOverride 900 true;
          "ghc-internal".components.library.planned = lib.mkOverride 900 true;
          "atomic-counter".components.library.planned = lib.mkOverride 900 true;
          "time".components.library.planned = lib.mkOverride 900 true;
          "ghc-bignum".components.library.planned = lib.mkOverride 900 true;
          "pretty".components.library.planned = lib.mkOverride 900 true;
          "th-compat".components.library.planned = lib.mkOverride 900 true;
          "os-string".components.library.planned = lib.mkOverride 900 true;
          "mtl".components.library.planned = lib.mkOverride 900 true;
          "binary".components.library.planned = lib.mkOverride 900 true;
          "directory-ospath-streaming".components.library.planned = lib.mkOverride 900 true;
          "ghc-boot-th".components.library.planned = lib.mkOverride 900 true;
          "cabal-install".components.exes."cabal".planned = lib.mkOverride 900 true;
          "hsc2hs".components.exes."hsc2hs".planned = lib.mkOverride 900 true;
          "hackage-security".components.library.planned = lib.mkOverride 900 true;
          "base".components.library.planned = lib.mkOverride 900 true;
          "process".components.library.planned = lib.mkOverride 900 true;
          "base16-bytestring".components.library.planned = lib.mkOverride 900 true;
          "open-browser".components.exes."example".planned = lib.mkOverride 900 true;
          "text".components.library.planned = lib.mkOverride 900 true;
          "splitmix".components.library.planned = lib.mkOverride 900 true;
          "ghc-prim".components.library.planned = lib.mkOverride 900 true;
          "async".components.library.planned = lib.mkOverride 900 true;
        };
      })
  ];
}
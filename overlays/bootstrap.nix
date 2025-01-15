final: prev:
let
    buildBootstrapper.compilerNixName = "ghc912";

    latestVer = {
      "9.8" = "9.8.1";
    };

in {
  haskell-nix = prev.haskell-nix // {

    # Use this to disable the existing haskell infra structure for testing purposes
    compiler = {
      ghc966 = final.haskell.compiler.ghc966;

      ghc981 = final.haskell.compiler.ghc981;
      ghc982 = final.haskell.compiler.ghc982;

      ghc912 = final.haskell.compiler.ghc912;
      ghc9121 = final.haskell.compiler.ghc912;
        };

    # Both `cabal-install` and `nix-tools` are needed for `cabalProject`
    # to check materialized results.  We need to take care that when
    # it is doing this we do not check the materialization of the
    # tools used or there will be infinite recursion.
    # always has `checkMaterialization = false` to avoid infinite
    # recursion.
    # cabal-install-tool = {compiler-nix-name, ...}@args:
    #   (final.haskell-nix.tool compiler-nix-name "cabal" ({pkgs, ...}: {
    #     evalPackages = pkgs.buildPackages;
    #     version = "3.10.1.0";
    #   } // final.lib.optionalAttrs (__compareVersions final.buildPackages.haskell-nix.compiler.${compiler-nix-name}.version "9.8.0" >= 0) {
    #     # It is important not to include this when not needed as it
    #     # introduces a eval time dependency on the `buildPackages`
    #     # version of nix-tools (on platforms where we cannot use the
    #     # static nix-tools).
    #     cabalProjectLocal = ''
    #       -- allow newer packages, that are bound to be newer due to
    #       -- being shipped with a newer compiler.  If you extend this
    #       -- be very careful to only extend it for absolutely necessary packages
    #       -- otherwise we risk running into broken build-plans down the line.
    #       allow-newer: *:base, *:template-haskell, *:bytestring, *:text

    #       repository head.hackage.ghc.haskell.org
    #         url: https://ghc.gitlab.haskell.org/head.hackage/
    #         secure: True
    #         key-threshold: 3
    #         root-keys:
    #            f76d08be13e9a61a377a85e2fb63f4c5435d40f8feb3e12eb05905edb8cdea89
    #            26021a13b401500c8eb2761ca95c61f2d625bfef951b939a8124ed12ecf07329
    #            7541f32a4ccca4f97aea3b22f5e593ba2c0267546016b992dfadcd2fe944e55d
    #         --sha256: sha256-h/vbKTUdGVdkt2ogJer2d+gRuHkayiblQ7oFRqpj14c=

    #       active-repositories: hackage.haskell.org, head.hackage.ghc.haskell.org:override
    #     '';
    #   } // final.lib.optionalAttrs (__compareVersions final.buildPackages.haskell-nix.compiler.${compiler-nix-name}.version "9.8.0" < 0) {
    #     index-state = final.haskell-nix.internalHackageIndexState;
    #     materialized = ../materialized + "/${compiler-nix-name}/cabal-install";
    #   } // args));

    # Memoize the cabal-install and nix-tools derivations by adding:
    #   haskell-nix.cabal-install.ghcXXX
    #   haskell-nix.cabal-install-unchecked.ghcXXX
    #   haskell-nix.nix-tools.ghcXXX
    #   haskell-nix.nix-tools-unchecked.ghcXXX
    # Using these avoids unnecessary calls to mkDerivation.
    # For cabal projects we match the versions used to the compiler
    # selected for the project to avoid the chance of a dependency
    # another GHC version (particularly useful on macOS where
    # executables are dynamically linked to GHC itself, which means
    # that if you use a tool built with a different GHC you will get
    # that GHC itself in your closure).
    # cabal-install = final.lib.mapAttrs (compiler-nix-name: _:
    #   final.haskell-nix.cabal-install-tool { inherit compiler-nix-name; }) final.haskell-nix.compiler;

    # WARN: The `import ../. {}` will prevent
    #       any cross to work, as we will loose
    #       the `config` value.
    # As such the following sadly won't work :(
    # haskellPackages = with import ../. {}; {
    #     hpack = null;
    #     hello = (hackage-package {
    #         inherit (final) cabal-install;
    #         name = "hello"; version = "1.0.0.2";
    #     }).components.exes.hello;
    # };

    # the bootstrap infrastructure (pre-compiled ghc; bootstrapped cabal-install, ...)
    bootstrap =
      let
        # This compiler-nix-name will only be used to build nix-tools and cabal-install
        # when checking materialization of alex, happy and hscolour.
        compiler-nix-name = buildBootstrapper.compilerNixName;
        # The ghc boot compiler to use to compile alex, happy and hscolour
        ghcOverride = final.buildPackages.haskell-nix.bootstrap.compiler.${compiler-nix-name};
        index-state = final.haskell-nix.internalHackageIndexState;
      in {
        compiler = final.haskell.compiler;
        packages = {}; /*{
            # now that we have nix-tools and hpack, we can just
            # use `hackage-package` to build any package from
            # hackage with haskell.nix.  For alex and happy we
            # need to use the boot strap compiler as we need them
            # to build ghcs from source.
            # guardMaterializationChecks is used here so we
            # can turn off materialization checks when
            # building ghc itself (since GHC is a dependency
            # of the materialization check it would cause
            # infinite recursion).
            alex-tool = args: final.haskell-nix.tool buildBootstrapper.compilerNixName "alex" ({config, pkgs, ...}: {
                compilerSelection = p: p.haskell.compiler;
                evalPackages = pkgs.buildPackages;
                version = "3.2.4";
                inherit ghcOverride index-state;
                materialized = ../materialized/bootstrap + "/${buildBootstrapper.compilerNixName}/alex";
                modules = [{ reinstallableLibGhc = false; }];
                nix-tools = config.evalPackages.haskell-nix.nix-tools;
            } // args);
            alex = final.haskell-nix.bootstrap.packages.alex-tool {};
            alex-unchecked = final.haskell-nix.bootstrap.packages.alex-tool { checkMaterialization = false; };
            happy-tool = { version ? "1.19.12", ... }@args: final.haskell-nix.tool buildBootstrapper.compilerNixName "happy"
              ({config, pkgs, ...}: {
                compilerSelection = p: p.haskell.compiler;
                evalPackages = pkgs.buildPackages;
                inherit version ghcOverride index-state;
                materialized = ../materialized/bootstrap + "/${buildBootstrapper.compilerNixName}/happy-${version}";
                modules = [{ reinstallableLibGhc = false; }];
                nix-tools = config.evalPackages.haskell-nix.nix-tools;
              } // args);
            happy = final.haskell-nix.bootstrap.packages.happy-tool {};
            happy-unchecked = final.haskell-nix.bootstrap.packages.happy-tool { checkMaterialization = false; };
            # Older version needed when building ghc 8.6.5
            happy-old = final.haskell-nix.bootstrap.packages.happy-tool { version = "1.19.11"; };
            happy-old-unchecked = final.haskell-nix.bootstrap.packages.happy-tool { version = "1.19.11"; checkMaterialization = false; };
            hscolour-tool = args: (final.haskell-nix.hackage-package
              ({config, pkgs, ...}: {
                compilerSelection = p: p.haskell.compiler;
                evalPackages = pkgs.buildPackages;
                compiler-nix-name = buildBootstrapper.compilerNixName;
                name = "hscolour";
                version = "1.24.4";
                inherit ghcOverride index-state;
                materialized = ../materialized/bootstrap + "/${buildBootstrapper.compilerNixName}/hscolour";
                modules = [{ reinstallableLibGhc = false; }];
                nix-tools = config.evalPackages.haskell-nix.nix-tools;
            } // args)).getComponent "exe:HsColour";
            hscolour = final.haskell-nix.bootstrap.packages.hscolour-tool {};
            hscolour-unchecked = final.haskell-nix.bootstrap.packages.hscolour-tool { checkMaterialization = false; };
        };*/
    };
  };
}

final: prev:
let
    buildBootstrapper.compilerNixName = "ghc8107";
    latestVer = {
      "9.8" = "9.8.2";
    };
    gitInputs = {
      ghc910X = "9.9";
      ghc911 = "9.11";
    };
    versionToNixName = v: "ghc${builtins.replaceStrings ["."] [""] v}";
    compilerNameMap =
      builtins.mapAttrs (source-name: v:
        versionToNixName "${v}.${builtins.substring 0 8 final.haskell-nix.sources.${source-name}.lastModifiedDate}")
          gitInputs //
      builtins.listToAttrs (map (v:
        { name = versionToNixName v; value = versionToNixName latestVer.${v}; })
          (builtins.attrNames latestVer));
in {
  haskell-nix = prev.haskell-nix // {
    # This can be used to map a compiler-nix-name from a shorter form.
    # For instance it will map:
    #   "ghc810" -> "ghc8107"
    #   "ghc99" -> "ghc9920230909" (uses last modified date of the git repo)
    inherit compilerNameMap;
    resolve-compiler-name = name: final.haskell-nix.compilerNameMap.${name} or name;
    # Use this to disable the existing haskell infra structure for testing purposes
    compiler = {
      ghc982 = final.haskell.compiler.ghc982.overrideAttrs (prevAttrs: {
        passthru = prevAttrs.passthru // {
          configured-src =
            (final.callPackage ../compiler/ghc-configure-src ({
                buildLlvmPackages = final.buildPackages.llvmPackages_12;
                llvmPackages = final.llvmPackages_12;

                src-spec = rec {
                    version = "9.8.2";
                    url = "https://downloads.haskell.org/~ghc/${version}/ghc-${version}-src.tar.xz";
                    sha256 = "sha256-4vt6fddGEjfSLoNlqD7dnhp30uFdBF85RTloRah3gck=";
                };
                hadrian = prevAttrs.passthru.hadrian;
                ghc = final.haskell.compiler.ghc982;
            })).passthru.configured-src;
        };
      });
        };

    # Both `cabal-install` and `nix-tools` are needed for `cabalProject`
    # to check materialized results.  We need to take care that when
    # it is doing this we do not check the materialization of the
    # tools used or there will be infinite recursion.
    # always has `checkMaterialization = false` to avoid infinite
    # recursion.
    cabal-install-tool = {compiler-nix-name, ...}@args:
      (final.haskell-nix.tool compiler-nix-name "cabal" ({pkgs, ...}: {
        evalPackages = pkgs.buildPackages;
        version = "3.10.1.0";
      } // final.lib.optionalAttrs (__compareVersions final.buildPackages.haskell-nix.compiler.${compiler-nix-name}.version "9.8.0" >= 0) {
        # It is important not to include this when not needed as it
        # introduces a eval time dependency on the `buildPackages`
        # version of nix-tools (on platforms where we cannot use the
        # static nix-tools).
        cabalProjectLocal = ''
          -- allow newer packages, that are bound to be newer due to
          -- being shipped with a newer compiler.  If you extend this
          -- be very careful to only extend it for absolutely necessary packages
          -- otherwise we risk running into broken build-plans down the line.
          allow-newer: *:base, *:template-haskell, *:bytestring, *:text

          repository head.hackage.ghc.haskell.org
            url: https://ghc.gitlab.haskell.org/head.hackage/
            secure: True
            key-threshold: 3
            root-keys:
               f76d08be13e9a61a377a85e2fb63f4c5435d40f8feb3e12eb05905edb8cdea89
               26021a13b401500c8eb2761ca95c61f2d625bfef951b939a8124ed12ecf07329
               7541f32a4ccca4f97aea3b22f5e593ba2c0267546016b992dfadcd2fe944e55d
            --sha256: sha256-h/vbKTUdGVdkt2ogJer2d+gRuHkayiblQ7oFRqpj14c=

          active-repositories: hackage.haskell.org, head.hackage.ghc.haskell.org:override
        '';
      } // final.lib.optionalAttrs (__compareVersions final.buildPackages.haskell-nix.compiler.${compiler-nix-name}.version "9.8.0" < 0) {
        index-state = final.haskell-nix.internalHackageIndexState;
        materialized = ../materialized + "/${compiler-nix-name}/cabal-install";
      } // args));

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
    cabal-install = final.lib.mapAttrs (compiler-nix-name: _:
      final.haskell-nix.cabal-install-tool { inherit compiler-nix-name; }) final.haskell-nix.compiler;
    cabal-install-unchecked = final.lib.mapAttrs (compiler-nix-name: _:
      final.haskell-nix.cabal-install-tool {
        compiler-nix-name =
          # If there is no materialized version for this GHC version fall back on
          # a version of GHC for which there will be.
          if builtins.pathExists (../materialized + "/${compiler-nix-name}/cabal-install/default.nix")
            then compiler-nix-name
            else "ghc928";
        checkMaterialization = false;
      }) final.haskell-nix.compiler;

    # These `internal` versions are used for:
    # * `nix-tools` for stack projects (since we use `nix-tools` to process
    #   the `stack.yaml` file we cannot match the ghc of the project the
    #   way we do for cabal projects).
    # * Scripts are used to update stackage and hackage
    # Updating the version of GHC selected here should be fairly safe as
    # there should be no difference in the behaviour of these tools.
    # (stack projects on macOS may see a significant change in the
    # closure size of their build dependencies due to dynamic linking).
    internal-cabal-install =
      final.haskell-nix.cabal-install-tool {
        compiler-nix-name = "ghc8107";
        compilerSelection = p: p.haskell.compiler;
        checkMaterialization = false;
      };

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

    # NOTE: 8.6.5 prebuilt binaries on macOS, will yield:
    #
    # > Linking dist/build/cabal/cabal ...
    # > Undefined symbols for architecture x86_64:
    # >  "_utimensat", referenced from:
    # >      _cazW_info in libHSdirectory-1.3.3.0.a(Posix.o)
    # > ld: symbol(s) not found for architecture x86_64
    # > clang-5.0: error: linker command failed with exit code 1 (use -v to see invocation)
    # > `clang' failed in phase `Linker'. (Exit code: 1)
    #
    # hence we'll use 844 for bootstrapping for now.

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
        packages = {
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
        };
    };
  };
}

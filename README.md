# `haskell.nix` is infrastructure for building Haskell packages with Nix

This is a fork that builds only Cabal projects, uses ghc from upstream
nixpkgs, and doesn't support cross platform builds / ghcjs builds. It
was forked after we had to build every ghc from 8.10.7 to 9.8.2 one
too many times. This fork also contains a bug fix that properly
respects index-state in presence of revisions.

There is a bug that is carried on from haskell.nix repo, where pinning
a different version of a ghc core library will silently fail i.e. the
plan succeeds but it'll always use the library shipped with the ghc
version which can be misleading.



`haskell.nix` can automatically translate your Cabal or Stack project and
its dependencies into Nix code.

## Documentation

- [Introduction](https://input-output-hk.github.io/haskell.nix/index.html)
- [Getting Started](https://input-output-hk.github.io/haskell.nix/tutorials/getting-started)
- [Troubleshooting](https://input-output-hk.github.io/haskell.nix/troubleshooting)
- Explore the documentation from there to find further topics.

## Help! Something isn't working

The #1 problem that people have when using `haskell.nix` is that they find themselves building GHC.
This should not happen, but you *must* follow the `haskell.nix` setup instructions properly to avoid it.
If you find this happening to you, please check that you have followed the
[getting started instructions](https://input-output-hk.github.io/haskell.nix/tutorials/getting-started#setting-up-the-binary-cache) and
consult the corresponding [troubleshooting section](https://input-output-hk.github.io/haskell.nix/troubleshooting#why-am-i-building-ghc).

The troubleshooting documentation also contains some help for other common issues. If you're still stuck open an issue.

## Related repos

The `haskell.nix` repository contains the runtime system for building
Haskell packages in Nix. It depends on other repos, which are:

- [`hackage.nix`](https://github.com/input-output-hk/hackage.nix) — the latest contents of the [Hackage](https://hackage.haskell.org/) databases, converted to Nix expressions.

- [`stackage.nix`](https://github.com/input-output-hk/stackage.nix) — all of the [Stackage](https://www.stackage.org/) snapshots, converted to Nix expressions.

> [!NOTE]
> For commercial support, please don't hesitate to reach out at devx@iohk.io

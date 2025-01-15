FROM glcr.b-data.ch/ghc/ghc-musl:9.12.1

RUN apk add libsodium-static zlib zlib-dev

WORKDIR /tmp/nix-tools

RUN cabal update

RUN cabal build all --only-dependencies

RUN cabal build all --enable-executable-static

RUN find ./dist-newstyle/build/x86_64-linux/ghc-9.12.1/*/x/ -type f -executable | xargs tar -cJf nix-tools-alpine.tar.xz

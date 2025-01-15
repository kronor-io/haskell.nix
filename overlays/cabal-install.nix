{ stdenv, fetchurl, lib }:

stdenv.mkDerivation rec {
  pname = "cabal-install";
  version = "3.14.1.1";

  src = fetchurl {
    url = "https://downloads.haskell.org/~cabal/cabal-install-${version}/cabal-install-${version}-x86_64-linux-alpine3_18.tar.xz";
    sha256 = "sha256-KA273YDQ3grmr0dkNghQkUjLLs8JZ80lW1q8skHZWd4=";
  };

  # Prevent Nix from automatically unpacking the source
  dontUnpack = true;

  # No build steps are required
  buildPhase = "";

  installPhase = ''
    mkdir -p $out/bin
    # Manually extract the tarball
    tar -xJf ${src}
    # Move the 'cabal' binary to $out/bin
    cp -v cabal $out/bin/
    # Ensure the binary is executable
    chmod +x $out/bin/cabal
  '';

  # No dependencies are needed since the binary is statically linked
  buildInputs = [];

  meta = with lib; {
    description = "The cabal-install tool (binary distribution)";
    homepage = "https://www.haskell.org/cabal/";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [];
  };
}

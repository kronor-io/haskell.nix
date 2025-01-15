{ stdenv, fetchurl, lib }:

stdenv.mkDerivation rec {
  pname = "nix-tools";
  version = "0.1.0.0";

  src = fetchurl {
    url = "https://pgnb.s3.ap-south-2.amazonaws.com/nix-tools-alpine-amd.tar.xz";
    sha256 = "sha256-/qff9cYlWGvlWPHgsgC9OXxidK4lrF754u91gh9BbTA=";
  };

  # Prevent Nix from automatically unpacking the source
  dontUnpack = true;

  # No build steps are required
  buildPhase = "";

  installPhase = ''
    mkdir -p $out/bin
    # Manually extract the tarball
    tar -xJf ${src}

    # Move all binaries to $out/bin
    find ./dist-newstyle/ -type f -executable | xargs -I {} cp -v {} $out/bin/

    # Ensure the binaries are executable
    chmod +x $out/bin/*
  '';

  # No dependencies are needed since the binary is statically linked
  buildInputs = [];

  meta = with lib; {
    description = "nix-tools";
    homepage = "https://github.com/input-output-hk/haskell.nix";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [];
  };
}

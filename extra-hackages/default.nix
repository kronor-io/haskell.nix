with builtins; mapAttrs (_: mapAttrs (_: data: rec {
 inherit (data) sha256;
 revisions = data.revisions // {
  default = revisions."${data.revisions.default}";
 };
})) {
  "ghc-internal" = import ./nix/ghc-internal.nix;

}

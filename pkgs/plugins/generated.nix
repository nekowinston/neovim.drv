{ callPackage, vimUtils }:
let
  nvfetcher = builtins.removeAttrs (callPackage ../../_sources/generated.nix { }) [
    "override"
    "overrideDerivation"
  ];
  plugins = builtins.mapAttrs (
    k: v:
    vimUtils.buildVimPlugin {
      inherit (v) pname src;
      version = v.date or v.version;

      passthru = { inherit (v) cargoLock; };
    }
  ) nvfetcher;
in
final: prev: plugins

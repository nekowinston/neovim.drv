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

      # FIXME: override nixpkgs vimPlugins instead of skipping the nvimRequireCheckHook
      # see: https://github.com/NixOS/nixpkgs/pull/360800
      doCheck = false;

      passthru = {
        inherit (v) cargoLock;
      };
    }
  ) nvfetcher;
in
final: prev: plugins

{ }:
final: prev: {
  venv-selector-nvim = prev.venv-selector-nvim.overrideAttrs (prevAttrs: {
    nvimSkipModule = [ "venv-selector.cached_venv" ];
  });
}

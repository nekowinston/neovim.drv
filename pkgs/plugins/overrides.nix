{ vimPlugins }:
final: prev: {
  neovim-session-manager = prev.neovim-session-manager.overrideAttrs (prevAttrs: {
    dependencies = [ vimPlugins.plenary-nvim ];
  });
  venv-selector-nvim = prev.venv-selector-nvim.overrideAttrs (prevAttrs: {
    nvimSkipModule = [ "venv-selector.cached_venv" ];
  });
}

final: prev:
let
  nvfetcher = prev.callPackage ../_sources/generated.nix { };
in
{
  java-debug = final.callPackage ./java-debug { };
  java-test = final.callPackage ./java-test { };

  tree-sitter-grammars = prev.tree-sitter-grammars // {
    tree-sitter-lean = prev.tree-sitter.buildGrammar {
      inherit (nvfetcher.tree-sitter-lean) pname src version;
      language = "lean";
    };
  };

  vimPlugins = prev.vimPlugins // {
    nvim-treesitter-parsers = prev.vimPlugins.nvim-treesitter-parsers // {
      lean = prev.vimPlugins.nvim-treesitter.grammarToPlugin final.tree-sitter-grammars.tree-sitter-lean;
    };
  };
}

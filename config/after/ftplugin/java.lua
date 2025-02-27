local jdtls_bin = vim.fn.exepath("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

if vim.g.lombok_path == nil and vim.fn.executable("lombok") then
	vim.g.lombok_path = vim.fn.exepath("lombok")
else
	vim.g.lombok_path = vim.fn.trim(
		vim.system({
			"nix-instantiate",
			"--eval",
			"--expr",
			"with import <nixpkgs> {}; lombok.outPath",
		})
			:wait().stdout,
		'"\n'
	)
end

local bundles = {
	vim.fn.glob(vim.g.java_debug_dir .. "com.microsoft.java.debug.plugin-*.jar", true),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(vim.g.java_test_dir .. "*.jar", true), "\n"))

require("jdtls").start_or_attach({
  -- stylua: ignore start
  cmd = {
    jdtls_bin,
    "-configuration", vim.fn.expand("~/.cache/jdtls"),
    "-data", vim.fs.joinpath(vim.fn.stdpath("data"), "/jdtls", project_name),
    "-javaagent:" .. vim.g.lombok_path,
  },
	-- stylua: ignore end
	init_options = { bundles = bundles },
	settings = {
		java = {
			import = {
				gradle = {
					enabled = true,
				},
				maven = {
					enabled = true,
				},
				exclusions = {
					"**/.direnv/**",
					"**/.metadata/**",
					"**/META-INF/maven/**",
					"**/archetype-resources/**",
					"**/node_modules/**",
					"/**/test/**",
				},
			},
		},
	},
})

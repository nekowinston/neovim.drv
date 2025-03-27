local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local cmd = {
	vim.fn.exepath("jdtls"),
	"-configuration",
	vim.fn.expand("~/.cache/jdtls"),
	"-data",
	vim.fs.joinpath(vim.fn.stdpath("data"), "/jdtls", project_name),
}

if vim.g.lombok_path == nil and vim.fn.executable("lombok") then
	vim.list_extend(cmd, { "-javaagent:" .. vim.fn.exepath("lombok") })
end

local bundles = {
	vim.fn.glob(vim.g.java_debug_dir .. "com.microsoft.java.debug.plugin-*.jar", true),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(vim.g.java_test_dir .. "*.jar", true), "\n"))

require("jdtls").start_or_attach({
	cmd = cmd,
	init_options = {
		bundles = bundles,
	},
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

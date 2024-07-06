local jdtls_bin = vim.fn.exepath("jdtls")
local jdtls_share = vim.fn.resolve(jdtls_bin .. "/../../share/java/jdtls")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

if vim.g.lombok_path == nil then
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

require("jdtls").start_or_attach({
  -- stylua: ignore start
	cmd = {
		jdtls_bin,
		"-configuration", vim.fn.expand("~/.cache/jdtls"),
		"-data",          vim.fs.joinpath(vim.fn.expand("~/workspace"), project_name),
		"-javaagent:" .. vim.g.lombok_path,
	},
	-- stylua: ignore end
	init_options = {
		bundles = { vim.env.JAVA_DEBUG_JAR },
	},
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
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

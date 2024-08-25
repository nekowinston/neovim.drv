vim.filetype.add({
	extension = {
		jq = "jq",
	},
	pattern = {
		[".*%.blade%.php"] = "blade",
		[".*%.html%.tera"] = "htmltera",
	},
	filename = {
		[".Justfile"] = "just",
		[".justfile"] = "just",
		["Justfile"] = "just",
		["justfile"] = "just",
	},
})

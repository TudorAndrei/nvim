require("telescope").setup({
	extensions = {
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "csv" },
		},
	},
})

require("leap").add_default_mappings()

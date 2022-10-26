require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-tool-installer").setup({
	ensure_installed = { "stylua", "shfmt", "shellcheck", "black", "isort", "vint", "pylama" , "pyright", "lua-language-server", "selene"},
	auto_update = true,
	run_on_start = true,
})
require("mason-lspconfig").setup({
	automatic_installation = true,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "MasonToolsUpdateCompleted",
	callback = function()
		vim.schedule(function()
			require("notify")("mason-tool-installer has finished")
		end)
	end,
})

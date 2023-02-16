require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"shfmt",
		"shellcheck",
		"black",
		-- "isort",
		"vint",
		"pylama",
		"pyright",
		"lua-language-server",
		"selene",
		"taplo",
		"prettierd",
		"rust-analyzer",
		"rustfmt",
		"yamllint",
		"yamlfmt",
		"yaml-language-server",
	},
	auto_update = true,
	run_on_start = true,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MasonToolsUpdateCompleted",
	callback = function()
		vim.schedule(function()
			require("notify")("mason-tool-installer has finished")
		end)
	end,
})

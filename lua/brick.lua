require("mason-tool-installer").setup({
	ensure_installed = {
		-- shell
		"shfmt",
		"shellcheck",

		-- python
		"black",
		"isort",
		-- "pylama",
		"pyright",
		"ruff-lsp",
		"pylint",
		"mypy",

		-- lua
		"lua-language-server",
		"stylua",
		"selene",
		-- toml
		"taplo",
		-- js/html/css
		"prettierd",

		"rust-analyzer",
		"rustfmt",

		-- yaml
		"yamllint",
		"yamlfmt",
		"yaml-language-server",
		-- vim
		"vint",
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

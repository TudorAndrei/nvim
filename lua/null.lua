-- package.path = package.path .. ";lsp.lua"

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- LSP Saga
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.keymap.set("i", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	-- Not properly handligh certain symbols
	-- vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, { silent = true,noremap = true})

	-- not using workspace folders
	-- vim.keymap.set("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	-- vim.keymap.set("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	-- vim.keymap.set("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

	vim.keymap.set("n", "<Leader>gf", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- vim.keymap.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.keymap.set("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	vim.keymap.set("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

	vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	-- vim.keymap.set("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

	-- vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	-- or jump to error
	vim.keymap.set("n", "[e", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true, noremap = true })
	vim.keymap.set("n", "]e", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true, noremap = true })

	vim.keymap.set("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.keymap.set("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.format({async = false})<CR>", opts)

	-- LSP SAGA
	vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, opts)
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
end
-- "https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting"
local formatting = null_ls.builtins.formatting
local diag = null_ls.builtins.diagnostics
null_ls.setup({
	on_attach = on_attach,
	sources = {
		-- python
		diag.mypy,
		formatting.black.with({
			extra_args = { "--fast" },
		}),
		formatting.isort.with({
			extra_args = { "--profile", " black" },
		}),
		-- diag.pydocstyle,
		--
		-- js
		formatting.prettier,
		formatting.latexindent,
		formatting.markdownlint.with({
			filetypes = { "markdown", "rmd", "telekasten" },
		}),
		-- diag.write_good,
		--
		formatting.stylua,
        -- vim
        diag.vint,
	},
})

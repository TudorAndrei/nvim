local pypath = vim.g.current_python_path
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")
local cmp = require("cmp")
local nvim_lsp = require("lspconfig")

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end
require("lspsaga").setup({})

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end
local formatting = null_ls.builtins.formatting
local diag = null_ls.builtins.diagnostics

lspkind.init()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/friendly-snips/" } })
require("cmp_pandoc").setup()

require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded",
	},
})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- LSP Saga
	-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
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
	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "cmp_pandoc" },
		{ name = "nvim-lsp_signature_help" },
		-- { name = "pandoc_references" },
		-- { name = "conjure" },
		{ name = "nvim_lua" },
		-- { name = "latex_symbols"},
		{ name = "emoji" },
		{ name = "path" },
		{ name = "omni" },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		}),
	},

	experimental = {
		native_menu = false,
	},
})
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	automatic_installation = true,
})

require("mason-lspconfig").setup_handlers({
	function(server_name)
		if server_name then
			local lspconfig = require("lspconfig")
			lspconfig[server_name].setup({})
		end
	end,
	["pyright"] = function()
		nvim_lsp.pyright.setup({
			on_attach = on_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			settings = {
				pyright = {
					disableLanguageServices = false,
				},
				python = {
					pythonPath = pypath,
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = false,
						typeCheckingMode = false,
					},
				},
			},
			flags = {
				debounce_text_changes = 150,
			},
		})
	end,
	["sumneko_lua"] = function()
		nvim_lsp.sumneko_lua.setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = vim.split(package.path, ";"),
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
					},
				},
			},
		})
	end,
})

null_ls.setup({
	on_attach = on_attach,
	sources = {
		-- python
		formatting.black.with({
			extra_args = { "--fast" },
		}),
		formatting.isort.with({
			extra_args = { "--profile", " black" },
		}),
		diag.pylama.with({
			"--from-stdin",
			"$FILENAME",
			"-f",
			"json",
			"-l",
			"eradicate,mccabe,pycodestyle,pydocstyle,pyflakes,pylint",
			"-m",
			"88",
		}),
		-- js
		formatting.prettierd,
		formatting.latexindent,
		formatting.markdownlint.with({
			filetypes = { "markdown", "rmd", "telekasten" },
		}),
		-- diag.write_good,
		formatting.stylua,
		-- vim
		diag.vint,
		-- lua
		diag.selene,
		-- toml
		formatting.taplo,
		-- rust
		formatting.rustfmt,
		formatting.yamlfmt,
		null_ls.builtins.completion.spell,
	},
})

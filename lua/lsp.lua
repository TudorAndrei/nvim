local pypath = vim.g.current_python_path
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")
lspkind.init()
local cmp = require("cmp")
local nvim_lsp = require("lspconfig")

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

require("lspconfig").vimls.setup({})
require("cmp_pandoc").setup()

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- local opts = { noremap=true, silent=true }
	local opts = { noremap = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<Leader>gf", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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

-- require'lspconfig'.r_language_server.setup{}

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
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
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
		{ name = "nvim_lua" },
		-- { name = "latex_symbols"},
		{ name = "emoji" },
		{ name = "path" },
		{ name = "omni" },
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				nvim_lsp = "[lsp]",
				nvim_lua = "[api]",
				buffer = "[buf]",
				path = "[path]",
				cmp_pandoc = "[pdc]",
				luasnip = "[snip]",
				gh_issues = "[issues]",
			},
		}),
	},

	experimental = {
		native_menu = false,
	},
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

require("lspconfig").racket_langserver.setup({})

-- USER = vim.fn.expand('$USER')

-- local sumneko_root_path = ""
-- local sumneko_binary = ""

-- if vim.fn.has("unix") == 1 then
--     sumneko_root_path = "/home/" .. USER .. "/projects/lua-language-server"
--     sumneko_binary = "/home/" .. USER .. "/projects/lua-language-server/bin/lua-language-server"
-- else
--     print("Unsupported system for sumneko")
-- end

-- require'lspconfig'.sumneko_lua.setup {
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--                 -- Setup your lua path
--                 path = vim.split(package.path, ';')
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {'vim'}
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
--             }
--         }
--     }
-- }

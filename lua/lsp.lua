local pypath = vim.g.current_python_path
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")
local cmp = require("cmp")
local nvim_lsp = require("lspconfig")

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

lspkind.init()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/friendly-snips/" } })
require("cmp_pandoc").setup()

require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = "rounded"
    }
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer=bufnr }

    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set("n", "gd", require("lspsaga.definition").peek_definition, opts)
    -- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- LSP Saga
    vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, opts)
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
    vim.keymap.set("n", "<Leader>rn", require("lspsaga.rename").lsp_rename, opts)
    vim.keymap.set("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

    vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
    -- vim.keymap.set("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

    -- vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    -- vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    vim.keymap.set("n", "[d", require("lspsaga.diagnostic").goto_prev, { silent = true, noremap = true })
    vim.keymap.set("n", "]d", require("lspsaga.diagnostic").goto_next, { silent = true, noremap = true })
    -- or jump to error
    vim.keymap.set("n", "[e", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true, noremap = true })
    vim.keymap.set("n", "]e", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true, noremap = true })

    vim.keymap.set("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.keymap.set("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- LSP SAGA
    vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, opts)
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
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

nvim_lsp.r_language_server.setup({
    on_attach = on_attach,
})

nvim_lsp.tsserver.setup({
    on_attach = on_attach,
})

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
        { name = 'nvim-lsp_signature_help' },
        -- { name = "pandoc_references" },
        { name = "conjure" },
        { name = "nvim_lua" },
        { name = "conventionalcommits" },
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
                omni = "[omni]",
                conjure = "[lisp]",
                conventionalcommits = "[git]",
            },
        }),
    },

    experimental = {
        native_menu = false,
    },
})

-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
-- cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

-- Racket
nvim_lsp.racket_langserver.setup({
    on_attach = on_attach,
})

-- Lua
USER = vim.fn.expand("$USER")

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER .. "/cave/lua-language-server"
    sumneko_binary = "/home/" .. USER .. "/cave/lua-language-server/bin/lua-language-server"
else
    print("Unsupported system for sumneko")
end

nvim_lsp.sumneko_lua.setup({
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
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

-- Vim ls
require("lspconfig").vimls.setup({
    on_attach = on_attach,
})

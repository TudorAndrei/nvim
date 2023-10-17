local pypath = vim.g.current_python_path
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use none-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
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
  local function map(mode, l, r, opts, desc)
    opts = opts or {}
    opts.buffer = bufnr
    opts.desc = desc
    vim.keymap.set(mode, l, r, opts)
  end

  map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts, "Go to definition")
  -- vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, "Go to declaration")
  -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- LSP Saga
  map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts, "Open Docs")
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts, "How implementations")
  map("i", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts, "Show signature")

  -- Not properly handligh certain symbols
  -- vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, { silent = true, noremap = true })

  -- not using workspace folders
  -- vim.keymap.set("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- vim.keymap.set("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- vim.keymap.set("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts, "Generate docstrings")
  map("n", "<Leader>gf", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts, "Go to type definition")
  -- vim.keymap.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  map("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>", opts, "Rename")
  map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts, "Code action")

  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, "Go to references")

  -- vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  map("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts, "Open diagnostics")
  -- vim.keymap.set("n", "<Leader>e", "<cmd>lua require('lsp_lines').toggle()<CR>", opts)

  -- vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  -- vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  -- map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts, "Go to prev diag")
  -- map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts, "Go to next diag")
  -- or jump to error
  map("n", "[d", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true, noremap = true })
  map("n", "]d", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true, noremap = true })

  map("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts, "Set loc list")
  map("n", "<Leader>fm", "<cmd>lua vim.lsp.buf.format({async = false})<CR>", opts, "Format file")

  -- LSP SAGA
  map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts, "Lsp finder")
  map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts, "Code action")
  map("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts, "Range code action")
end
return {

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
    ---@class PluginLspOpts
    opts = {
      -- inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        pyright = {
          on_attach = on_attach,
          settings = {
            pyright = {
              disableLanguageServices = false,
              disableOrganizeImports = true,
            },
            python = {
              pythonPath = pypath,
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
              },
            },
          },
          flags = {
            debounce_text_changes = 150,
          },
          pylyzer = {
            on_attach = on_attach,
            python = {
              checkOnType = false,
              diagnostics = true,
              inlayHints = true,
              smartCompletion = true,
            },
          },
        },
      },
    },
  },
  {
    "danymat/neogen",
    opts = {
      enabled = true,
      snippet_engine = "luasnip",
      languages = {
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    opts = {
      ui = {
        title = false,
        -- border = false,
      },
    },
  },
}

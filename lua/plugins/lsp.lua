local pypath = vim.g.current_python_path

return {
  { "lepture/vim-jinja" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        ruff_lsp = function()
          LazyVim.lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
      inlay_hints = { enabled = true },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        jinja_lsp = {},
        clangd = {},
        docker_compose_language_service = {},
        dockerls = {},
        jsonls = {},
        rust_analyzer = {},
        tailwindcss = {
          filetypes_include = { "jinja" },
        },
        taplo = {},
        tsserver = {},
        yamlls = {},
        biome = {},
        ruff_lsp = {
          -- ruff = {
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              typeCheckingMode = "basic",
            },
            python = {
              pythonPath = pypath,
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
              },
            },
          },
          flags = {
            debounce_text_changes = 150,
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        html = { "djlint", "rustywind" },
        jinja = { "djlint", "rustywind" },
        css = { "prettierd" },
        python = { "ruff_lsp" },
        lua = { "stylua" },
        yaml = { "yamlfmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene" },
        css = { "stylelint" },
        markdown = { "markdownlint" },
        yaml = { "yamllint" },
        dockerfile = { "hadolint" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
  -- TODO: check the default
  {
    "danymat/neogen",
    keys = {
      { "<leader>nf", "<cmd>:lua require('neogen').generate()<CR>", desc = "Generate docstrings" },
    },
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
        border = false,
      },
    },
  },
  {
    "nvim-neotest/neotest-python",
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          python = ".venv/bin/python",
        },
      },
    },
  },
}

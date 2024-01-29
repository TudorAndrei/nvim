local pypath = vim.g.current_python_path

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
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

        clangd = {},
        docker_compose_language_service = {},
        dockerls = {},
        jsonls = {},
        rust_analyzer = {},
        tailwindcss = {},
        taplo = {},
        tsserver = {},
        yamlls = {},
        biome = {},
        ruff_lsp = {},
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true,
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
        javascript = { { "prettierd", "prettier" } },
        python = { "ruff-lsp" },
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
  {
    "danymat/neogen",
    keys = {
      { "<leader>nf", "<cmd>:lua require('neogen').generate()<CR>", desc = "Open file tree" },
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
        -- border = false,
      },
    },
  },
}

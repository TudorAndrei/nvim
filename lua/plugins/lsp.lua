local nixos_dir = "~/nixos-config/"

vim.diagnostic.config({
  signs = false,
})

return {
  { "lepture/vim-jinja" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        ["*"] = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = false,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        nixd = {
          settings = {
            nixd = {
              formatting = {
                command = { "alejandra" },
              },
              nixpkgs = {
                expr = string.format("import (builtins.getFlake %s).inputs.nixpkgs {}", nixos_dir),
              },
              options = {
                nixos = {
                  expr = string.format("(builtins.getFlake %s).nixosConfiguration.sparta.options", nixos_dir),
                },
                home_manager = {
                  expr = string.format(
                    "(builtins.getFlake %s).homeConfigurations.%s.options",
                    nixos_dir,
                    os.getenv("USER")
                  ),
                },
              },
            },
          },
        },
        jinja_lsp = {},
        clangd = {},
        docker_language_server = {},
        jsonls = {},
        rust_analyzer = {},
        rumdl = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = require("lspconfig.util").root_pattern(".rumdl.toml", ".git")(fname)
            on_dir(root or vim.fs.dirname(fname))
          end,
        },
        tailwindcss = {
          filetypes_include = { "jinja" },
        },
        taplo = {},
        yamlls = {},
        oxlint = {},
        ruff = {
          capabilities = {
            hoverProvider = false,
          },
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
        ty = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        html = { "djlint", "rustywind" },
        jinja = { "djlint", "rustywind" },
        css = { "oxfmt" },
        python = { "ruff" },
        lua = { "stylua" },
        yaml = { "yamlfmt" },
        markdown = { "rumdl" },
        ["markdown.mdx"] = { "rumdl" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.lua = { "selene" }
      opts.linters_by_ft.css = { "stylelint" }
      opts.linters_by_ft.dockerfile = { "hadolint" }
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft["markdown.mdx"] = {}
      opts.linters = opts.linters or {}
      opts.linters.selene = {
        condition = function(ctx)
          return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        end,
      }
      return opts
    end,
  },
  -- TODO: check the default
  {
    "danymat/neogen",
    keys = {
      { "<leader>nf", "<cmd>:lua require('neogen').generate()<CR>", desc = "Generate docstrings" },
    },
    opts = {
      enabled = true,
      snippet_engine = "nvim",
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

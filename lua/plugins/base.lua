-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "Mofiqul/dracula.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
  {
    "ggandor/leap.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      return {
        { "<leader>fl", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fr", "<cmd>Telescope file_browser<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep in files" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find opened buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find in help" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search in keybinds" },
        { "z=", "<cmd>Telescope spell_suggest<cr>", desc = "Suggest word" },
      }
    end,
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "bash",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "rust",
      },
      highlight = {
        enable = true,
      },
      rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
      },
      indent = {
        enable = true,
      },
      refactor = {
        highlight_definitions = { enable = true },
      },
      autotag = {
        enable = true,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
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
        -- "pylint",
        -- "mypy",

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
    },
  },
  { "tpope/vim-obsession" },
  -- {
  --   "alexghergh/nvim-tmux-navigation",
  --   opts = {
  --     disable_when_zoomed = true, -- defaults to false
  --     -- keybindings = {
  --     --   left = "<C-h>",
  --     --   down = "<C-j>",
  --     --   up = "<C-k>",
  --     --   right = "<C-l>",
  --     --   last_active = "<C-\\>",
  --     --   next = "<C-Space>",
  --     -- },
  --     keys = function()
  --       return {
  --         { "<c-h>", "<cmd>NvimTmuxNavigateLeft<cr>", desc = "Tmux nav left" },
  --         { "<c-j>", "<cmd>NvimTmuxNavigateDown<cr>", desc = "Tmux nav down" },
  --         { "<c-k>", "<cmd>NvimTmuxNavigateUp<cr>", desc = "Tmux nav up" },
  --         { "<c-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Tmux nav right" },
  --         { "<c-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", desc = "Tmux nav last active" },
  --       }
  --     end,
  --   },
  -- },
  { "nathom/tmux.nvim" },
}

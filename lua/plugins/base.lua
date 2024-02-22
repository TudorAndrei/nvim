return {
  { "Mofiqul/dracula.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
  -- {
  --   "ggandor/leap.nvim",
  -- },
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      return {
        { "<leader>fl", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep in files" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find opened buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find in help" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search in keybinds" },
        { "<leader>fx", "<cmd>Telescope bibtex<cr>", desc = "Search in bibtex" },
        { "<leader>fs", "<cmd>Telescope symbols<cr>", desc = "Search symbols" },
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
      "nvim-telescope/telescope-symbols.nvim",
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
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-bibtex.nvim",
      config = function()
        require("telescope").load_extension("bibtex")
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "hjson",
        "c",
        "rust",
        "lua",
        "typescript",
        "python",
        "javascript",
        "bash",
        "html",
        "dockerfile",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "yaml",
        "json",
        "toml",
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
    "dariuscorvus/tree-sitter-surrealdb.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- setup step
      require("tree-sitter-surrealdb").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- docker
        "hadolint",
        -- shell
        "shfmt",
        "shellcheck",
        -- lua
        "stylua",
        "selene",
        -- toml
        "taplo",
        -- js/html/css
        "biome",
        -- rust
        "rust-analyzer",
        -- yaml
        "yamllint",
        "yamlfmt",
        "yaml-language-server",
        -- vim
        "vint",
      },
    },
  },
  { "nathom/tmux.nvim" },
}

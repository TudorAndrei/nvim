local function mysplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local function conda_env()
  local conda_pref = os.getenv("CONDA_PREFIX")
  if string.find(conda_pref, "envs") then
    local env = mysplit(conda_pref, "/")
    return (string.format("🐍%s", env[#env]))
  else
    return ""
  end
end

local function venv_env()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    local env = mysplit(venv, "/")
    return (string.format("(%s)", env[#env]))
  else
    return ""
  end
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = false,
}

local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "rmd" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return ""
  end
end

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

return {
  -- {
  --   "folke/edgy.nvim",
  --   enable = false,
  --   event = "VeryLazy",
  --   init = function()
  --     vim.opt.laststatus = 3
  --     vim.opt.splitkeep = "screen"
  --   end,
  --   opts = {
  --     bottom = {},
  --     left = {
  --       {
  --         ft = "nvim-tree",
  --         pinned = true,
  --         open = "NvimTreeToggle",
  --       },
  --       {
  --         ft = "Outline",
  --         pinned = true,
  --         open = "SymbolsOutlineOpen",
  --         height = { 0.4 },
  --       },
  --     },
  --   },
  -- },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "dracula",
          icons_enabled = true,
          component_separators = {},
          section_separators = {},
          disabled_filetypes = { "dashboard", "TelescopePrompt" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { branch },
          lualine_c = { "filename", diagnostics },
          lualine_x = { diff, "encoding", { getWords } },
          lualine_y = { filetype, conda_env, venv_env },
          lualine_z = { location },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { location },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "trouble", "fzf", "mason", "nvim-tree", "lazy", "symbols-outline" },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
  },
  {
    "folke/lsp-colors.nvim",
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_icons = false, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = { "|" },
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
        show_tab_indicators = true,
      },
    },
  },
  {
    "kyazdani42/nvim-tree.lua",
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Open file tree" },
    },
    opts = {
      disable_netrw = true,
      hijack_netrw = true,
      diagnostics = {
        enable = false,
      },
      filters = {
        custom = {
          "^.git$",
          ".*.aux$",
          ".*.bbl$",
          ".*.fls$",
          ".*.fdb_latexmk$",
          ".*.toc$",
          ".*.out$",
          ".*.bcf$",
          ".*.lbx$",
          ".*.run.xml$",
          ".*.synctex.gz$",
        },
        exclude = { "data", ".env", ".db_conf" },
      },
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
          },
        },
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    opts = {
      enable_check_bracket_line = false,
    },
  },
}

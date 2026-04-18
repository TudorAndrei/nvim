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

local function venv_env()
  local venv_prompt = os.getenv("VIRTUAL_ENV_PROMPT")
  if venv_prompt then
    return venv_prompt
  else
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
      local env = mysplit(venv, "/")
      return (string.format("(%s)", env[#env]))
    else
      return ""
    end
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

local function hide_in_width()
  return vim.fn.winwidth(0) > 80
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
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, {})
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
          lualine_x = {
            {
              function()
                return require("direnv").status_line()
              end,
            },
            diff,
            "encoding",
            { getWords },
          },
          lualine_y = { filetype, venv_env },
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
        extensions = { "trouble", "mason", "nvim-tree", "lazy", "symbols-outline" },
      }
    end,
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
    "windwp/nvim-autopairs",
    opts = {
      enable_check_bracket_line = false,
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "LazyFile",
    ft = { "html" },
    opts = {
      html = {
        mode = "foreground",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      log_level = "warn",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },
}

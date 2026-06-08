return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    lazy = false,
    opts = {
      layout = {
        width = 0.8,
        height = 0.8,
        prompt_position = "bottom",
        preview_position = "right",
        preview_size = 0.5,
      },
    },
    keys = {
      { "<leader><space>", function() require("fff").find_files() end, desc = "Find Files (Root Dir)" },
      { "<leader>ff", function() require("fff").find_files() end, desc = "Find Files (Root Dir)" },
      { "<leader>/", function() require("fff").live_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>sg", function() require("fff").live_grep() end, desc = "Grep (Root Dir)" },
    },
  },
  -- Disable snacks_picker keybindings that fff replaces
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader><space>", false },
      { "<leader>ff", false },
      { "<leader>/", false },
      { "<leader>sg", false },
    },
  },
}

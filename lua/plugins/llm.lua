return {
  "nomnivore/ollama.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- All the user commands added by the plugin
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

  -- Sample keybind for prompting. Note that the <c-u> is important for selections to work properly.
  keys = {
    {
      "<leader>oo",
      ":<c-u>lua require('ollama').prompt()<cr>",
      desc = "ollama prompt",
      mode = { "n", "v" },
    },
  },

  ---@type Ollama.Config
  opts = {
    model = "openhermes2.5-mistral:latest",
    prompts = {
      Sample_Prompt = {
        prompt = "Optimize this code $buf",
        input_label = "> ",
        model = "openhermes2.5-mistral:latest",
        action = "display",
      },
    },
  },
  {
    "dustinblackman/oatmeal.nvim",
    cmd = { "Oatmeal" },
    keys = {
      { "<leader>om", mode = "n", desc = "Start Oatmeal session" },
    },
    opts = {
      backend = "ollama",
      model = "openhermes2.5-mistral:latest",
    },
  },
}

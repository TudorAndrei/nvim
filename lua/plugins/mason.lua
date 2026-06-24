return {
  {
    "mason-org/mason.nvim",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      auto_update = true,
      run_on_start = true,
      ensure_installed = {
        "djlint",
        "rustywind",
        "prettierd",
        "yamlfmt",
        "stylelint",
        "yamllint",
        "hadolint",
        "selene",
        "stylua",
        "oxlint",
        "oxfmt",
        "rumdl",
      },
    },
  },
}

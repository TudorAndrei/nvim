require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}
require("mason-tool-installer").setup {
    ensure_installed = { "stylua", "shfmt", "shellcheck", "black", "isort", "vint" },
    auto_update = false,
    run_on_start = true,
}
require("mason-lspconfig").setup({
    automatic_installation = true,
})

 require("trouble").setup {

    }
require'telescope'.setup {
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg", 'pdf', 'csv'},
    }
  },
}

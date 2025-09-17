-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require'lspconfig'.fortls.setup{}

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true, additional_vim_regex_highlighting = false },
}

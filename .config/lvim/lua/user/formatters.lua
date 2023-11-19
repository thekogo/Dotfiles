lvim.format_on_save.enabled = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "gofumpt",
    filetypes = { "go" }
  },
  {
    name = "goimports",
    filetypes = { "go" }
  },
  {
    name = "prettier",
    filetypes = { "tmpl" }
  },
}

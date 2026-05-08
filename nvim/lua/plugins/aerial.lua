-- Workaround: aerial 2.7.0's treesitter backend crashes on Neovim 0.12
-- (range_from_nodes receives nil). Disable that backend; LSP/markdown still work.
return {
  "stevearc/aerial.nvim",
  opts = {
    backends = { "lsp", "markdown", "man" },
  },
}

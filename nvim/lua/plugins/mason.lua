-- Customize Mason / mason-tool-installer.
-- v6: mason.nvim moved from `williamboman/` to `mason-org/`; no spec change
-- needed here because we only configure the tool installer.

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- language servers
        "lua-language-server",
        "ruff", -- Astral's Python linter/formatter LSP
        "ltex-ls",
        -- formatters
        "stylua",
        -- debuggers
        "debugpy",
        -- other
        "tree-sitter-cli",
      },
    },
  },
}

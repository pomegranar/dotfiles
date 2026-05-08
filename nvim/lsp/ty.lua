-- Per-server config for Astral's `ty` Python type checker.
-- Discovered automatically by Neovim 0.12+ via `lsp/<name>.lua` (`:h lsp-config`).
-- ty is not yet in nvim-lspconfig; install with `uv tool install ty`.

---@type vim.lsp.Config
return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = {
    "ty.toml",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
  settings = {},
}

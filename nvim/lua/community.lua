-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  event = { "lazy" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  { import = "astrocommunity.colorscheme.gruvbox-baby" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
}

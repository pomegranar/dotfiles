-- Colorschemes available alongside AstroTheme and the astrocommunity imports.

return {
  {
    "Shatur/neovim-ayu",
    init = function()
      require("ayu").setup {
        mirage = false,
        terminal = true,
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {},
  },
  { "tjdevries/colorbuddy.nvim" },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup { filter = "spectrum" }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    opts = {},
  },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    opts = {
      underline_links = true,
    },
  },
}

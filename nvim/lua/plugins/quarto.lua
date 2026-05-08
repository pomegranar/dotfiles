-- Quarto support. Python LSP is provided by Ruff + Ty (see astrolsp.lua, lsp/ty.lua).
-- Cell navigation and Quarto leader maps live in astrocore.lua.

return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        enabled = true,
        languages = { "python", "bash", "lua", "html", "javascript" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = { enabled = true },
      },
      keymap = false,
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    config = function(_, opts) require("quarto").setup(opts) end,
  },

  {
    "jmbuhr/otter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    lazy = true,
    ft = { "quarto", "markdown" },
    dependencies = { "3rd/image.nvim" },
    config = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
  },

  {
    "3rd/image.nvim",
    lazy = true,
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "quarto" },
        },
      },
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}

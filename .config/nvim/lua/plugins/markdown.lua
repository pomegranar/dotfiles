return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx", "quarto" },
    opts = {
      heading = {
        enabled = true,
        sign = true,
        position = "inline",
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}

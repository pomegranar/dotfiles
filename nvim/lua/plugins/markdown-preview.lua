return {
  {
    "tweekism/markdown-preview.nvim",
    ft = { "markdown", "mdx" },
    build = "cd app && npx --yes yarn install",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    config = function() vim.g.mkdp_filetypes = { "markdown", "mdx" } end,
  },
}

return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- View method: 'skim' on macOS, 'zathura' on Linux
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_compiler_method = "tectonic"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "build",
    }
    vim.g.vimtex_compiler_autostart = 1
    vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { desc = "Compile LaTeX" })
  end,
}

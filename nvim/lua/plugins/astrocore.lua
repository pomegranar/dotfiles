-- AstroCore configures core features, vim options, mappings, treesitter, and autocommands.
-- See `:h astrocore`.

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- v6: treesitter configuration lives here; nvim-treesitter is now just a parser downloader.
    treesitter = {
      highlight = {
        enable = true,
        disable = { "latex" }, -- vimtex provides its own latex highlighting
      },
      indent = true,
      auto_install = true,
      ensure_installed = {
        "lua",
        "vim",
        "markdown",
        "markdown_inline",
        "python",
        "yaml",
        "latex",
        "bash",
        "html",
        "javascript",
        "json",
        "toml",
      },
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = true,
      },
      g = {},
    },
    mappings = {
      n = {
        -- buffer navigation
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- swap `;` and `:` so `;` opens command mode without Shift
        [";"] = { ":", desc = "Open command mode" },
        [":"] = { ";", desc = "Repeat last f/F/t/T" },

        -- Quarto group + commands
        ["<Leader>m"] = { desc = "󰠮 Quarto" },
        ["<Leader>mp"] = { "<cmd>QuartoPreview<cr>", desc = "Preview Quarto document" },
        ["<Leader>mc"] = { "<cmd>QuartoClosePreview<cr>", desc = "Close Quarto preview" },
        ["<Leader>mr"] = { "<cmd>QuartoSendAbove<cr>", desc = "Run cells above" },
        ["<Leader>mR"] = { "<cmd>QuartoSendAll<cr>", desc = "Run all cells" },

        -- Quarto cell navigation
        ["]m"] = { function() require("quarto").qmd.next_code_cell() end, desc = "Next code cell" },
        ["[m"] = { function() require("quarto").qmd.prev_code_cell() end, desc = "Previous code cell" },
      },
      v = {
        [";"] = { ":", desc = "Open command mode" },
        [":"] = { ";", desc = "Repeat last f/F/t/T" },
        ["<Leader>mr"] = { "<cmd>QuartoSend<cr>", desc = "Run selected code" },
      },
    },
  },
}

-- User plugin overrides: dashboard, autopairs LaTeX rule, LuaSnip + LaTeX snippets.

---@type LazySpec
return {
  -- Customized snacks dashboard
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}

      local version_art = "nvim – The Editor of the Future"
      opts.dashboard.preset.header = version_art

      opts.dashboard.preset.keys = vim.list_extend(opts.dashboard.preset.keys or {}, {
        { icon = " ", key = "z", desc = ".zshrc", action = ":e ~/.zshrc" },
        {
          icon = " ",
          key = "c",
          desc = "Projects/",
          action = function() require("snacks").picker.files { cwd = vim.fn.expand "~/Developer/" } end,
        },
        {
          icon = " ",
          key = "v",
          desc = "neovim config/",
          action = function() require("snacks").picker.files { cwd = vim.fn.stdpath "config" } end,
        },
        { icon = " ", key = "g", desc = "ghostty config", action = ":e ~/.config/ghostty/config" },
      })

      opts.dashboard.sections = {
        { section = "header", padding = 5 },
        { section = "keys", gap = 0, padding = 3 },
        { section = "startup" },
      }

      return opts
    end,
  },

  -- Autopairs LaTeX `$` rule
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules({
        Rule("$", "$", { "tex", "latex" })
          :with_pair(cond.not_after_regex "%%")
          :with_pair(cond.not_before_regex("xxx", 3))
          :with_move(cond.none())
          :with_del(cond.not_after_regex "xx")
          :with_cr(cond.none()),
      }, Rule("a", "a", "-vim"))
    end,
  },

  -- LuaSnip (snippet engine) + LaTeX snippets
  { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    dependencies = "L3MON4D3/LuaSnip",
    config = function() require("luasnip-latex-snippets").setup() end,
    ft = { "tex", "markdown" },
  },
}

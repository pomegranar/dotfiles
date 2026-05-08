-- AstroUI configures the AstroNvim UI (colorscheme, highlights, icons).
-- See `:h astroui`.

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    highlights = {
      astrotheme = {
        DiagnosticHint = { fg = "#00B29880", sp = "#00B29880", undercurl = true },
        DiagnosticVirtualTextHint = { fg = "#00B29880" },
        DiagnosticUnderlineHint = { sp = "#00B29880", undercurl = true },
      },
    },
    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}

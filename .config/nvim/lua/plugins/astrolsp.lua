-- AstroLSP configures AstroNvim's LSP engine.
-- v6: language server configs are passed to `vim.lsp.config`; the default
-- handler enables servers via `vim.lsp.enable`. Per-server overrides live
-- in this `config` table or in `lsp/<server>.lua` files at the config root.
-- See `:h astrolsp`.

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {},
      },
      disabled = {
        -- Ty does not provide formatting; Ruff handles Python formatting.
        "ty",
      },
      timeout_ms = 2000,
    },
    -- Servers to enable. Configs come from nvim-lspconfig defaults, this file's
    -- `config` table, or `lsp/<server>.lua` (used here for `ty`, which isn't in lspconfig).
    servers = {
      "hls",
      "ltex",
      "ruff",
      "ty",
    },
    ---@diagnostic disable: missing-fields
    config = {
      hls = {
        settings = {
          haskell = {
            formattingProvider = "ormolu",
            plugin = {
              hlint = { globalOn = true },
              ormolu = { globalOn = true },
            },
          },
        },
      },
      ltex = {
        settings = {
          ltex = {
            language = "en-US",
            dictionary = {
              ["en-US"] = { ":" .. vim.fn.stdpath "config" .. "/ltex/en-US.txt" },
            },
            disabledRules = {
              ["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
            },
          },
        },
      },
      ruff = {
        -- Let Ty own hover so we get type info instead of Ruff's noqa docs.
        on_attach = function(client, _) client.server_capabilities.hoverProvider = false end,
      },
    },
    handlers = {},
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then
              vim.lsp.codelens.refresh { bufnr = args.buf }
            end
          end,
        },
      },
    },
    mappings = {
      n = {
        K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
      },
    },
    on_attach = function(_, _) end,
  },
}

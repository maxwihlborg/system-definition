local handlers = require "pde.lsp.handlers"

local config = {
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "none",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)
vim.lsp.config("*", {
  capabilities = handlers.get_client_capabilites(),
  on_attach = handlers.on_attach,
})

vim.lsp.enable {
  "cssls",
  "harper_ls",
  "jsonls",
  "lua_ls",
  "prismals",
  "rescriptls",
  "rust_analyzer",
  "taplo",
  "yamlls",
  -- "biome",
  -- "eslint",
  -- "graphql",
  -- "tailwindcss",
  -- "ts_ls",
}

require("typescript-tools").setup {
  capabilities = handlers.get_client_capabilites(),
  on_attach = handlers.on_attach,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {},
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    tsserver_locale = "en",
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    code_lens = "off",
    disable_member_code_lens = true,
    jsx_close_tag = {
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
  },
}

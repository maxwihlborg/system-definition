local M = {}

local function get_client_capabilites()
  local blink_ok, blink = pcall(require, "blink.cmp")
  if blink_ok then
    return blink.get_lsp_capabilities(nil, true)
  end
  return vim.lsp.protocol.make_client_capabilities()
end

function M.setup()
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
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  local status_ok, inc_rename = pcall(require, "inc_rename")
  if status_ok then
    inc_rename.setup {}
  end
end

local function lsp_mappings(bufnr)
  require("pde.utils").load_keymap("lsp", {
    buffer = bufnr,
    silent = true,
    noremap = true,
  })
end

local function lsp_commands(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  local group = vim.api.nvim_create_augroup("PdeLSP", {
    clear = true,
  })

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function() vim.lsp.buf.document_highlight() end,
    buffer = bufnr,
    group = group,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    callback = function() vim.lsp.buf.clear_references() end,
    buffer = bufnr,
    group = group,
  })
end

local function ts_mappings(bufnr)
  require("pde.utils").load_keymap("lsp.ts", {
    buffer = bufnr,
    silent = true,
    noremap = true,
  })
end

---@diagnostic disable-next-line: unused-local
local function ts_attach_utils(client, bufnr)
  local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
  client.server_capabilities.documentFormattingProvider = false

  if not status_ok then
    return
  end

  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,

    -- import all
    import_all_timeout = 5000, -- ms
    import_all_scan_buffers = 100,
    import_all_select_source = false,

    always_organize_imports = false,

    -- inlay hints
    auto_inlay_hints = false,

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
  }

  ts_utils.setup_client(client)
end

local function lsp_winbar(client, bufnr)
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end

  if client.server_capabilities.documentSymbolProvider and client.name ~= "graphql" then
    navic.attach(client, bufnr)
  end
end

local function ts_attach_twoslash(client, bufnr)
  local status_ok, twoslash = pcall(require, "twoslash-queries")
  if not status_ok then
    return
  end

  twoslash.attach(client, bufnr)
end

local function ts_on_attach(client, bufnr)
  ts_attach_utils(client, bufnr)
  ts_attach_twoslash(client, bufnr)
  ts_mappings(bufnr)
end

function M.on_attach(client, bufnr)
  if client.name == "ts_ls" then
    ts_on_attach(client, bufnr)
  end
  lsp_mappings(bufnr)
  lsp_winbar(client, bufnr)
  lsp_commands(client, bufnr)
end

M.capabilities = get_client_capabilites()

return M

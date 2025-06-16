local M = {}

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
  ts_attach_twoslash(client, bufnr)
  ts_mappings(bufnr)
end

function M.on_attach(client, bufnr)
  if client.name == "typescript-tools" then
    ts_on_attach(client, bufnr)
  end
  lsp_mappings(bufnr)
  lsp_winbar(client, bufnr)
  lsp_commands(client, bufnr)
end

function M.get_client_capabilites()
  local blink_ok, blink = pcall(require, "blink.cmp")
  if blink_ok then
    return blink.get_lsp_capabilities(nil, true)
  end
  return vim.lsp.protocol.make_client_capabilities()
end

return M

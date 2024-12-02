local handlers = require "pde.lsp.handlers"

local M = {}

function M.setup_autostart(lsp)
  local ok_lspconfig, lspconig = pcall(require, "lspconfig")
  if not ok_lspconfig then
    return
  end

  local lsp_group = vim.api.nvim_create_augroup("lspconfig", { clear = false })

  local client = lspconig[lsp]
  local event
  local pattern

  if client.filetypes then
    event = "FileType"
    pattern = table.concat(client.filetypes, ",")
  else
    event = "BufReadPost"
    pattern = "*"
  end

  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    group = lsp_group,
    callback = function(opt)
      client.manager.try_add(opt.buf)
    end,
  })
end

function M.get_options(lsp)
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }
  local opt_ok, extend_opt = pcall(require, "pde.lsp.servers." .. lsp)
  if opt_ok then
    opts = vim.tbl_deep_extend("force", extend_opt, opts)
  end
  return opts
end

return M

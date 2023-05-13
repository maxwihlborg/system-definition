local handlers = require "pde.lsp.handlers"

local M = {}

local ok_mason_lspconfig = pcall(require, "mason-lspconfig")
local ok_lspconfig, lspconig = pcall(require, "lspconfig")
local ok_mason = pcall(require, "mason")

function M.setup_autostart(lsp)
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

function M.ensure_installed(lsp)
  if not (ok_mason and ok_mason_lspconfig) then
    return
  end

  local Package = require "mason-core.package"
  local registry = require "mason-registry"

  local resolve_package = function(lspconfig_server_name)
    local Optional = require "mason-core.optional"
    local server_mapping = require "mason-lspconfig.mappings.server"

    return Optional.of_nilable(server_mapping.lspconfig_to_package[lspconfig_server_name]):map(function(package_name)
      local ok, pkg = pcall(registry.get_package, package_name)
      if ok then
        return pkg
      end
    end)
  end

  local mason_name, version = Package.Parse(lsp)

  resolve_package(mason_name):if_present(function(pkg)
    if not pkg:is_installed() then
      pkg:install {
        version = version,
      }
    end
  end)
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

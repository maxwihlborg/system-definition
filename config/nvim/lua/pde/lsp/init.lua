local handlers = require "pde.lsp.handlers"
local utils = require "pde.lsp.utils"

local lspconfig = require "lspconfig"

handlers.setup()

local mason_ok, mason = pcall(require, "mason-lspconfig")
if mason_ok then
  mason.setup_handlers {
    function(lsp)
      lspconfig[lsp].setup(utils.get_options(lsp))
    end,
  }
end

local M = {}

function M.init()
  local signs = {
    { name = "DapBreakpoint", text = "", hl = "DapBreakpoint" },
    { name = "DapBreakpointCondition", text = "ﳁ", hl = "DapBreakpoint" },
    { name = "DapBreakpointRejected", text = "", hl = "DapBreakpoint" },
    { name = "DapLogPoint", text = "" },
    { name = "DapStopped", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.hl or sign.name, text = sign.text, numhl = "" })
  end
end

function M.setup()
  local adapters = require "pde.dap.adapters"
  adapters.setup()
end

return M

local M = {}

function M.init()
  local group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    command = "FormatWrite",
    group = group,
  })
end

function M.setup()
  require("pde.formatter.setup").setup()
end

return M

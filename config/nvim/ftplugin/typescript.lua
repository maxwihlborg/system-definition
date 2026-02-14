--[[
local utils = require "pde.utils"
utils.set_compiler("tsc", {
  pattern = { "typescript", "typescriptreact" },
  cmd = function()
    local dir = utils.find_package_json_dir()
    assert(dir ~= nil, "Could not find root dir")
    return string.format("pnpm --dir %s exec tsc", dir)
  end,
})
]]

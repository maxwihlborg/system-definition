local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim", "utils" },
        redefinedLocal = false,
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
          [vim.fn.stdpath "data" .. "/site/pack/packer/start/base46/lua"] = true,
        },
        checkThirdParty = false,
        maxPreload = 10000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

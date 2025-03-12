return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        redefinedLocal = false,
        missingFields = false,
      },
      workspace = {
        checkThirdParty = false,
        maxPreload = 10000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

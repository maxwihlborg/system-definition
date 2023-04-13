return {
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = {
        {
          description = "NPM",
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package",
        },
        {
          description = "Cosmos UI",
          fileMatch = { "cosmos.config.json" },
          url = "http://json.schemastore.org/cosmos-config",
        },
        {
          description = "Turbo",
          fileMatch = { "turbo.json" },
          url = "https://turborepo.org/schema.json",
        },
        {
          description = "bsconfig",
          fileMatch = { "bsconfig.json" },
          url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/master/docs/docson/build-schema.json",
        },
        {
          description = "JSConfig",
          fileMatch = { "jsconfig.json", "jsconfig.*.json" },
          url = "https://json.schemastore.org/jsconfig",
        },
        {
          description = "TSconfig",
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "https://json.schemastore.org/tsconfig",
        },
        {
          description = "Lerna",
          fileMatch = { "lerna.json" },
          url = "https://json.schemastore.org/lerna",
        },
        {
          description = "Babel",
          fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
          url = "https://json.schemastore.org/babelrc.json",
        },
        {
          description = "ESLint",
          fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "https://json.schemastore.org/eslintrc",
        },
        {
          description = "Prettier",
          fileMatch = { ".prettierrc.json", "prettier.config.json" },
          url = "https://json.schemastore.org/prettierrc",
        },
        {
          description = "Vercel",
          fileMatch = { "now.json", "vercel.json" },
          url = "https://json.schemastore.org/now",
        },
      },
    },
  },
}

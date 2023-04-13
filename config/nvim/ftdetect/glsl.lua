-- Extensions supported by Khronos reference compiler (with one exception, ".glsl")
-- https://github.com/KhronosGroup/glslang
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "*.vert",
    "*.tesc",
    "*.tese",
    "*.glsl",
    "*.geom",
    "*.frag",
    "*.comp",
    "*.rgen",
    "*.rmiss",
    "*.rchit",
    "*.rahit",
    "*.rint",
    "*.rcall",
  },
  callback = function()
    vim.opt.filetype = "glsl"
  end,
})

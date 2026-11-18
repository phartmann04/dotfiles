return {
  cmd = { "lua-language-server"},
  filetypes = { "lua" },
  root_markers = {
    {
      ".luarc.json",
      ".laurc.jsonc",
    },
    ".git"
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},  -- Recognize 'vim' as a global variable
      },
    },
  }
}

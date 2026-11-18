---@brief
---
--- https://clangd.llvm.org/
---
--- clangd is a language server for C/C++

---@type vim.lsp.Config
return {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
  },
  settings = {
    clangd = {
      InlayHints = {
        Enabled = true,
        ParameterHints = true,
        TypeHints = true,
        ChainingHints = true,
      },
      Diagnostics = {
        ClangTidy = true,
        ClangTidyChecks = "readability-*",
      },
    },
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimplementedMethods = true,
    semanticTokens = true,
  },
}

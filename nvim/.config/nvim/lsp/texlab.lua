return {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'latex', 'plaintex', 'context' },
  root_markers = {
    'texlabroot',
    '.git',
  },
  settings = {
    texlab = {
      -- Build configuration
      build = {
        executable = 'latexmk',
        args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
        onSave = false,
        forwardSearchAfterBuild = false,
      },
      -- Forward search (Synctex support)
      forwardSearch = {
        executable = 'zathura',
        args = { '--synctex-forward', '%l:%c:%f', '%p' },
      },
      -- Auxiliary files to ignore
      auxDirectory = '.',
      -- Formatting configuration
      formatting = {
        latexFormatter = 'latexindent',
        bibtexFormatter = 'texlab',
      },
    },
  },
}

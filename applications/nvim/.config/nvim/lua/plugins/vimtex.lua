return {
  "lervag/vimtex",
  lazy = false,

  config = function()
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'cmd.exe'
    vim.g.vimtex_view_general_options = [[/c start "" "C:/Users/kazirahman/AppData/Local/SumatraPDF/SumatraPDF.exe" -reuse-instance -forward-search "@tex" @line "@pdf"]]

    -- -- Tell VimTeX/latexmk to use xelatex as the default engine
    -- vim.g.vimtex_compiler_latexmk_engines = {
    --   _ = '-xelatex',
    -- }
  end
}

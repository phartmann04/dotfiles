return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown" },
      callback = function(args)
        pcall(vim.treesitter.stop, args.buf)
        vim.bo[args.buf].syntax = "markdown"
      end,
    })
  end,

  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "lua",
      },
      auto_install = false,  -- Disable auto_install to prevent compilation issues
      highlight = {
        enable = true,
        disable = { "markdown", "markdown_inline" },
        additional_vim_regex_highlighting = { "markdown", "latex" },
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown" },
      callback = function(args)
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.treesitter.stop, args.buf)
            vim.bo[args.buf].syntax = "markdown"
          end
        end)
      end,
    })

    -- Use Vim's native syntax highlighting for LaTeX files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "tex", "latex", "plaintex", "context" },
      callback = function(args)
        -- Disable treesitter for LaTeX if parser not available
        if not pcall(vim.treesitter.start, args.buf, "latex") then
          vim.bo[args.buf].syntax = "tex"
        end
      end,
    })
  end
}

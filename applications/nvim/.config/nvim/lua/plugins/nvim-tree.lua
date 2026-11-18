return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local set = vim.keymap.set

    set("n", "<leader>nf", "<cmd>NvimTreeFocus<CR>", { desc = "Open and focus file tree" })
    set("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      api.config.mappings.default_on_attach(bufnr)

      local opts = function(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      vim.keymap.set('n', 'c', function()
        api.fs.clear_clipboard()
        api.fs.copy.node()
      end, opts('Overwrite to nvim clipboard'))

    end

    require("nvim-tree").setup({
      on_attach = my_on_attach,
    })
  end,
}

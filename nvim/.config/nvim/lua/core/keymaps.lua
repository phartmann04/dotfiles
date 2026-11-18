-- General keymaps that are non-plugin specific

local set = vim.keymap.set

-- Buffers
set("n", "<C-s>", ":w<CR>", { desc = "Saves current buffer" })
set("i", "<C-s>", "<C-o>:w<CR>", { desc = "Saves current buffer" })
set("n", "<leader><Right>", ":bnext<CR>", { desc = "Next buffer" })
set("n", "<leader><Left>", ":bprev<CR>", { desc = "Previous buffer" })

set("n", "<leader>bd", function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd("bnext")
  vim.cmd("bd " .. bufnr)
end, { desc = "Close buffer but keep split" })

-- Highlight
set("n", "<Esc>", ":noh<CR>", { desc = "Clears search highlight" })

-- Easier window navigation
set("n", "<leader>h", "<C-w>h", { desc = "Go to Left window" })
set("n", "<leader>j", "<C-w>j", { desc = "Go to Lower window" })
set("n", "<leader>k", "<C-w>k", { desc = "Go to Upper window" })
set("n", "<leader>l", "<C-w>l", { desc = "Go to Right window" })
set("n", "<leader>q", ":q<CR>", { desc = "Closes buffer" })

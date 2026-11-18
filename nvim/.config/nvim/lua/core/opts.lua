-- LEADER
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.opt

-- General
set.title = true
set.titlestring = "virgin"

set.number = true
set.relativenumber = true

set.cursorline = true
set.ruler = true
set.termguicolors = true

-- Indentation
set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2

-- Search
set.ignorecase = true
set.smartcase = true
set.gdefault = true
set.incsearch = true
set.hlsearch = true
set.wrapscan = true

-- UI
set.mouse = "a"

-- Clipboard
vim.g.clipboard = {
  name = 'win32yank-wsl',
  copy = {
    ['+'] = 'win32yank.exe -i --crlf',
    ['*'] = 'win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = 'win32yank.exe -o --lf',
    ['*'] = 'win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}

-- Yank into system clipboard
vim.keymap.set({'n', 'v'}, 'y', '"+y')
vim.keymap.set('n', 'yy', '"+yy')
vim.keymap.set('n', 'Y', '"+Y')

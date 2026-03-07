vim.g.mapleader = " " 
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 8
vim.opt.timeoutlen = 300
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = {
  "n-v-c:block-blinkon400-blinkoff400",
  "i-ci-ve:ver25-blinkon400-blinkoff400",
  "r-cr:hor20-blinkon400-blinkoff400",}
vim.o.showmatch = true
vim.o.matchtime = 2
vim.keymap.set('i', 'kj', '<Esc>', { noremap = true, silent = true })
vim.cmd.colorscheme("retrobox")


-- 1. SETTINGS
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
  "n-v-c:block-blinkon400-blinkoff400",          -- Normal, Visual, Command: Blinking Block
  "i-ci-ve:ver25-blinkon400-blinkoff400",       -- Insert, Command-Insert, Visual-Ex: Blinking Line (25% width)
  "r-cr:hor20-blinkon400-blinkoff400",          -- Replace: Blinking Underline
}
vim.keymap.set('i', 'kj', '<Esc>', { noremap = true, silent = true })
-- showmatch: highlight matching brackets
vim.o.showmatch = true           -- permanent equivalent of :set showmatch
vim.o.matchtime = 2              -- duration in tenths of a second, optional
vim.cmd("hi MatchParen guibg=#FFD700 guifg=NONE")  -- bright background

vim.cmd("hi RainbowRed guibg=#3A3A3A guifg=#FF5555")    -- red background
vim.cmd("hi RainbowYellow guibg=#3A3A3A guifg=#F1FA8C")
vim.cmd("hi RainbowBlue guibg=#3A3A3A guifg=#8BE9FD")
vim.cmd("hi RainbowGreen guibg=#3A3A3A guifg=#50FA7B")
vim.cmd("hi RainbowViolet guibg=#3A3A3A guifg=#BD93F9")

-- 2. BOOTSTRAP LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3. PLUGINS
require("lazy").setup({
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function() vim.cmd([[colorscheme tokyonight-storm]])end },
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "windwp/nvim-ts-autotag", opts = {} },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" } },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "typescript", "javascript", "html", "css", "lua", "vim", "vimdoc" },
        highlight = { 
            enable = true },
            extended_mode = true,
            max_file_lines = nil,
      })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
    end
  },
 {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use main branch
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration goes here
        })
    end,
 }, 
 {
    "stevearc/conform.nvim",
    config = function()
        require("config.conform")
    end,
 },
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({})
  end,
},
{
    "andymass/vim-matchup",
    event = "BufRead",
}
})

-- 4. LSP & CMP
local caps = require('cmp_nvim_lsp').default_capabilities()

-- Define servers with optional settings
local servers = { "ts_ls", "html", "css", "eslint", "emmet_ls" }

for _, server in ipairs(servers) do
  vim.lsp.config(server, { capabilities = caps })
end

-- Enable all servers
vim.lsp.enable(servers)   

local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' } })
})

-- 5. LSP KEYMAPS

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- Add opts here so 'gl' is buffer-local too!
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts) 
  end,
})

return {
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
}

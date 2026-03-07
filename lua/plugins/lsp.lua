return {

  {
    "williamboman/mason.nvim",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = function()

      local caps = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "ts_ls", "html", "css", "eslint", "emmet_ls" }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = caps })
      end

      vim.lsp.enable(servers)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        end,
      })

    end,
  },

}

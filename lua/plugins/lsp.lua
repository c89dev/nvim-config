return {

  {
    "williamboman/mason.nvim",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "ts_ls",
        "html",
        "cssls",
        "eslint",
        "emmet_ls",
      },
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()

      local caps = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "clangd", "ts_ls", "html", "cssls", "eslint" }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = caps,
        })
      end

      vim.lsp.config("emmet_ls", {
        capabilities = caps,
        filetypes = {
          "html",
          "css",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
      })

      vim.lsp.enable({
        "clangd",
        "ts_ls",
        "html",
        "cssls",
        "eslint",
        "emmet_ls",
      })

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

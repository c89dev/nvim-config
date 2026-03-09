return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },

    config = function()

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        completion = {
          completeopt = "menu,menuone,noinsert",
        },

        mapping = cmp.mapping.preset.insert({

          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping.complete(),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },

        sorting = {
          priority_weight = 2,
          comparators = {

            -- force emmet below other LSPs
            function(entry1, entry2)

              local c1 = entry1.source.source and entry1.source.source.client
              local c2 = entry2.source.source and entry2.source.source.client

              if c1 and c2 then

                if c1.name == "emmet_ls" and c2.name ~= "emmet_ls" then
                  return false
                end

                if c2.name == "emmet_ls" and c1.name ~= "emmet_ls" then
                  return true
                end

              end

            end,

            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,

          },
        },

      })

    end,
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}

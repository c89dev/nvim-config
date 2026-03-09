return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mxsdev/nvim-dap-vscode-js",
    },

    config = function()

      local dap = require("dap")

      local dapui = require("dapui")
      dapui.setup()

      -- setup vscode js debugger
    require("dap-vscode-js").setup({
      debugger_path = "/usr/lib/js-debug",
      adapters = { "pwa-node", "pwa-chrome" },
    })

      -- Node / backend debugging
      dap.configurations.javascript = {
        {
          name = "Debug current file (Node)",
          type = "pwa-node",
          request = "launch",

          program = "${file}",
          cwd = "${workspaceFolder}",

          runtimeExecutable = "node",
          console = "integratedTerminal",

          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },

        -- Browser / frontend debugging
        {
          name = "Attach to Chromium",
          type = "pwa-chrome",
          request = "attach",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      }

      -- make TS use the same configs
      dap.configurations.typescript = dap.configurations.javascript

      -- keymaps
      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<F10>", dap.step_over)
      vim.keymap.set("n", "<F11>", dap.step_into)
      vim.keymap.set("n", "<F12>", dap.step_out)

      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

      -- open / close dap ui automatically
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

    end
  }
}

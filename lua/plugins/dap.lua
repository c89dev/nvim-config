return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			-- JS DEBUG ADAPTER
			-- connect to js-debug-dap TCP server
			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "::1",
				port = 8123,
			}

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "::1",
				port = 8123,
			}

			-- JAVASCRIPT CONFIGS
			dap.configurations.javascript = {

				-- Node debugging
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

				-- Browser debugging
				{
					name = "Attach to Chromium",
					type = "pwa-chrome",
					request = "attach",

					port = 9222,
					webRoot = "${workspaceFolder}/src",
				},
			}

			-- TypeScript shares JS configs
			dap.configurations.typescript = dap.configurations.javascript

			-- KEYMAPS

			-- Start / Continue execution
			vim.keymap.set("n", "<F5>", dap.continue)

			-- Step line-by-line
			vim.keymap.set("n", "<F8>", dap.step_over)

			-- Step into function
			vim.keymap.set("n", "<F9>", dap.step_into)

			-- Step out of function
			vim.keymap.set("n", "<F10>", dap.step_out)

			-- Toggle breakpoint
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

			vim.keymap.set("n", "<leader>dw", function()
				require("dapui").elements.watches.add(vim.fn.expand("<cword>"))
			end)

			-- UI AUTO OPEN/CLOSE

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}

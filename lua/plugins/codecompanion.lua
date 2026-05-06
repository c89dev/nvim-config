return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- For file search slash command
	},
	opts = {
		strategies = {
			chat = {
				adapter = "gemini_cli",
				slash_commands = {
					["buffer"] = {
						callback = "strategies.chat.slash_commands.buffer",
						description = "Insert the current buffer content",
						opts = {
							contains_code = true,
						},
					},
					["file"] = {
						callback = "strategies.chat.slash_commands.file",
						description = "Insert a file content",
						opts = {
							contains_code = true,
							provider = "telescope",
						},
					},
					["symbols"] = {
						callback = "strategies.chat.slash_commands.symbols",
						description = "Insert symbols for the current buffer",
						opts = {
							contains_code = true,
						},
					},
				},
			},
			inline = {
				adapter = "gemini",
			},
			agent = {
				adapter = "gemini",
			},
		},
		adapters = {
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					schema = {
						model = {
							default = "gemini-2.0-flash",
						},
					},
				})
			end,
			gemini_cli = function()
				return require("codecompanion.adapters").extend("gemini_cli", {
					commands = {
						default = {
							"gemini",
							"--acp",
						},
					},
				})
			end,
		},
		display = {
			chat = {
				show_settings = true,
				window = {
					layout = "vertical",
					width = 0.45,
					height = 0.8,
				},
			},
		},
	},
	keys = {
		{ "<leader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		{ "<leader>c", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },
		{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
	},
}

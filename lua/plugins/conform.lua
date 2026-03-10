return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			clangd = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},

		formatters = {
			prettier = {
				prepend_args = {
					"--tab-width",
					"4",
					"--use-tabs",
					"false",
					"--config-precedence",
					"cli-override",
				},
			},
		},

		notify_on_error = true,
		notify_no_formatters = true,
	},
}

return {
	{
		"windwp/nvim-ts-autotag",
		enabled = false,
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = function()
			return {
				pre_hook = function(ctx)
					local ok, parser = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
					if ok and parser then
						return require("Comment.ft").calculate(ctx)
					end
					return vim.bo.commentstring
				end,
			}
		end,
	},
}

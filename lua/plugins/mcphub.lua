return {
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "bundled_build.lua",
		opts = {
			config = vim.fn.stdpath("config") .. "/mcphub/servers.json",
			use_bundled_binary = true,
		},
	},
}

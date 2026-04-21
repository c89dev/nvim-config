return {
	{
		"L3MON4D3/LuaSnip",
		config = function()
			vim.api.nvim_create_autocmd("InsertLeave", {
				callback = function()
					local ok, ls = pcall(require, "luasnip")
					if not ok then
						return
					end
					ls.unlink_current()
				end,
			})
		end,
	},
}

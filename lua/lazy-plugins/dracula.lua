return {
	"Mofiqul/dracula.nvim",
	-- to load before everything
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("dracula")
	end,
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
}

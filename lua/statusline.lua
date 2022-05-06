local lualine = require("lualine")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local function getWords()
	if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "rmd" then
		if vim.fn.wordcount().visual_words == 1 then
			return tostring(vim.fn.wordcount().visual_words) .. " word"
		elseif not (vim.fn.wordcount().visual_words == nil) then
			return tostring(vim.fn.wordcount().visual_words) .. " words"
		else
			return tostring(vim.fn.wordcount().words) .. " words"
		end
	else
		return ""
	end
end

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local config = {
	options = {
		theme = "dracula",
		icons_enabled = true,
		component_separators = { "", "" },
		section_separators = { "", "" },
		disabled_filetypes = { "dashboard", "NvimTree", "Outline", "TelescopePrompt" },

        globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch },
		lualine_c = { "filename", diagnostics },
		lualine_x = { diff, "encoding", { getWords } },
		lualine_y = { filetype },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { location },
		lualine_y = {},
		lualine_z = {},
	},
}
lualine.setup(config)
require("bufferline").setup({
	options = {
		show_buffer_icons = false, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
	},
})

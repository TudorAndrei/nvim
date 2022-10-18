local lualine = require("lualine")

local function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local function conda_env()
    local conda_pref = os.getenv("CONDA_PREFIX")
    if string.find(conda_pref, "envs") then
        local env = mysplit(conda_pref, "/")
        return (string.format("🐍%s", env[#env]))
    else
        return ""
    end
end

local function venv_env()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        local env = mysplit(venv, "/")
        return (string.format("(%s)", env[#env]))
    else
        return ""
    end
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = false,
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
        lualine_y = { filetype, conda_env, venv_env},
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
        separator_style = { "|" },
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
        show_tab_indicators = true,
    },
})
require("fidget").setup({})

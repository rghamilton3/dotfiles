local vault = vim.fn.expand("~") .. "/obsidian-vault/Second Brain/k"
local wk = require("which-key")

-- The group option doesn't work if the keymap is changed inside
-- the returned plugin object using "keys".
wk.add({
  {
    "gf",
    function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<Cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end,
    desc = "Obsidian Follow Link",
  },
  { "<Leader>o", group = "notes", icon = { icon = "", color = "purple" } },
  {
    "<Leader>oo",
    ":cd " .. vault .. "<cr>",
    desc = "Navigate to Obsidian Vault",
    icon = { icon = " ", color = "purple" },
  },
  { "<Leader>on", ":ObsidianTemplate note<cr>", desc = "Format note using template" },
  {
    "<Leader>os",
    ":Telescope find_files search_dirs={" .. vault .. "}<cr>",
    desc = "Find Notes",
    icon = { icon = "󰱼" },
  },
  {
    "<Leader>oz",
    ":Telescope live_grep search_dirs={" .. vault .. "}<cr>",
    desc = "Grep Notes",
    icon = { icon = "" },
  },
  { "<Leader>oD", ":!rm '%:p'<cr>:bd<cr>", desc = "Delete current note", icon = { icon = "󰆴", color = "red" } },
})

return {
  "epwalsh/obsidian.nvim",
  -- Use latest release instead of latest commit
  version = "*",

  lazy = true,

  -- Only load plugin for markdown files in vault
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/obsidian-vault/Second Brain/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/obsidian-vault/Second Brain/*.md",
  },

  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "saghen/blink.cmp",
  },

  opts = {
    workspaces = {
      {
        name = "Second Brain",
        path = vim.fn.expand("~") .. "/obsidian-vault/Second Brain",
      },
    },
    notes_subdir = "0 Inbox",
    new_notes_location = "notes_subdir",

    disable_frontmatter = true,

    use_advanced_uri = true,
    finder = "telescope.nvim",

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S",
      substitutions = {
        title = function()
          local b_name = vim.fn.expand("%")
          local prefix = "%a*/%d%d%d%d%-%d%d%-%d%d_"
          local title, _ = string.gsub(b_name, prefix, "")
          title, _ = string.gsub(title, "%-", " ")
          title, _ = string.gsub(title, "%.md", "")
          return title:sub(1, 1):upper() .. title:sub(2)
        end,
      },
    },

    ui = {
      enable = false,
    },

    -- By default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open or function(url)
      require("astrocore").system_open(url)
    end,
  },
}

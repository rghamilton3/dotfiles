return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre "
        .. vim.fn.expand("~")
        .. "/Vaults/Second Brain/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Vaults/Second Brain/*.md",
    },

    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },

    ---@module 'obsidian'
    ---@type obsidian.config.ClientOpts
    opts = {
      workspaces = {
        {
          name = "Second Brain",
          -- can be a full path or relative to the current working directory
          path = vim.fn.expand("~") .. "/Vaults/Second Brain",
        },
      },

      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",

      disable_frontmatter = true,
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
        substitutions = {
          title = function()
            local file_name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
            local formatted_name = string.gsub(file_name, ".md", "")
            formatted_name = string.gsub(formatted_name, "^[%d%-]*_", "") -- remove any leading numbers and hyphens
            formatted_name = string.gsub(formatted_name, "-", " ") -- replace hyphens with spaces
            local function titleCase(first, rest)
              return first:upper() .. rest:lower()
            end

            formatted_name = string.gsub(formatted_name, "(%a)([%w_']*)", titleCase)
            return formatted_name
          end,
        },
      },

      completion = {
        nvim_cmp = false,
        blink = true,
        min_chars = 2,
      },

      picker = {
        name = "snacks.pick",
      },

      -- ui = {
      --   -- Disable some things below here because I set these manually for all Markdown files using treesitter
      --   checkboxes = {},
      --   bullets = {},
      -- },
    },
  },
}

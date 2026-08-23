 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#e1e7ea',
    base01 = '#d6dee1',
    base02 = '#cfd9dd',
    base03 = '#78868c',
    base04 = '#505558',
    base05 = '#181a1b',
    base06 = '#181a1b',
    base07 = '#181a1b',
    base08 = '#fd4663',
    base09 = '#52476b',
    base0A = '#4e587e',
    base0B = '#508195',
    base0C = '#453960',
    base0D = '#355664',
    base0E = '#394160',
    base0F = '#fab7c2',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#181a1b',          bg = '#e1e7ea' })
  hi('TelescopeBorder',         { fg = '#78868c',             bg = '#e1e7ea' })
  hi('TelescopePromptNormal',   { fg = '#181a1b',          bg = '#e1e7ea' })
  hi('TelescopePromptBorder',   { fg = '#78868c',             bg = '#e1e7ea' })
  hi('TelescopePromptPrefix',   { fg = '#508195',             bg = '#e1e7ea' })
  hi('TelescopePromptCounter',  { fg = '#505558',  bg = '#e1e7ea' })
  hi('TelescopePromptTitle',    { fg = '#e1e7ea',             bg = '#508195' })
  hi('TelescopePreviewTitle',   { fg = '#e1e7ea',             bg = '#4e587e' })
  hi('TelescopeResultsTitle',   { fg = '#e1e7ea',             bg = '#52476b' })
  hi('TelescopeSelection',      { fg = '#181a1b',          bg = '#cfd9dd' })
  hi('TelescopeSelectionCaret', { fg = '#508195',             bg = '#cfd9dd' })
  hi('TelescopeMatching',       { fg = '#508195',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M

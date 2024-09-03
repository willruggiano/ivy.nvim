local api = require "ivy"

-- Put the controller in to the vim global so we can access it in mappings
-- better without requires. You can call controller commands like `vim.ivy.xxx`.
-- luacheck: ignore
vim.ivy = api

vim.paste = (function(overridden)
  return function(lines, phase)
    local file_type = vim.api.nvim_buf_get_option(0, "filetype")
    if file_type == "ivy" then
      vim.ivy.paste()
    else
      overridden(lines, phase)
    end
  end
end)(vim.paste)

vim.cmd "highlight IvyMatch cterm=bold gui=bold"

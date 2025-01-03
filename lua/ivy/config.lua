local config_mt = {}
config_mt.__index = config_mt

function config_mt:get_in(config, key_table)
  local current_value = config
  for _, key in ipairs(key_table) do
    if current_value == nil then
      return nil
    end

    current_value = current_value[key]
  end

  return current_value
end

function config_mt:get(key_table)
  return self:get_in(self.user_config, key_table) or self:get_in(self.default_config, key_table)
end

local config = { user_config = {} }

config.default_config = {
  backends = {
    "ivy.backends.buffers",
    "ivy.backends.files",
    "ivy.backends.lines",
    "ivy.backends.rg",
    "ivy.backends.lsp-workspace-symbols",
  },
  mappings = {
    ["<C-c>"] = "destroy",
    ["<C-u>"] = "clear",
    ["<C-n>"] = "next",
    ["<C-p>"] = "previous",
    ["<C-M-n>"] = "next_checkpoint",
    ["<C-M-p>"] = "previous_checkpoint",
    ["<CR>"] = "complete",
    ["<C-v>"] = "vsplit",
    ["<C-s>"] = "split",
    ["<BS>"] = "backspace",
    ["<Left>"] = "left",
    ["<Right>"] = "right",
    ["<C-w>"] = "delete_word",
  },
}

return setmetatable(config, config_mt)

vim.opt.rtp:append(vim.fn.getcwd())

local ivy = require "ivy"
local prompt = require "ivy.prompt"
require "plugin.ivy"

if #vim.v.argv ~= 5 then
  print "[ERROR] Expected 5 arguments"
  print "    Usage: nvim -l ./scripts/integration.lua <directory> <search>"

  return
end

ivy.setup()

vim.fn.chdir(vim.v.argv[4])
print("Working in " .. vim.fn.getcwd())

vim.cmd "IvyFd"

for _, value in pairs(vim.split(vim.v.argv[5], "")) do
  local start_time = os.clock()

  vim.ivy.input(value)
  vim.wait(0)

  local running_time = os.clock() - start_time

  io.stdout:write(prompt.text() .. "\t" .. running_time .. "\n")
end

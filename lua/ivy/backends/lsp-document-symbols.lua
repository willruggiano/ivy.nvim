local window = require "ivy.window"
local utils = require "ivy.utils"

local previous_results = {}
local function set_items(items)
  window.set_items(items)
  previous_results = items
end

local function items()
  local bufnr = window.origin_buffer
  local winnr = window.origin
  local cwd = vim.fn.getcwd()
  local results = {}
  vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", function(client)
    return vim.lsp.util.make_position_params(winnr, client.offset_encoding)
  end, function(err, server_result)
    if err ~= nil then
      set_items { content = "-- There was an error with textDocument/documentSymbol --" }
      return
    end
    local locations = vim.lsp.util.symbols_to_items(server_result or {}, bufnr) or {}
    for index = 1, #locations do
      local item = locations[index]
      local relative_path = item.filename:sub(#cwd + 2, -1)
      table.insert(results, { content = relative_path .. ":" .. item.lnum .. ": " .. item.text })
    end

    set_items(results)
  end)

  return previous_results
end

local lsp_document_symbols = {
  name = "DocumentSymbols",
  command = "IvyDocumentSymbols",
  description = "Search for document symbols using the lsp textDocument/documentSymbol",
  items = items,
  callback = utils.vimgrep_action(),
}

return lsp_document_symbols

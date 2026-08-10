local M = {}

function M.is_hex_color_light(hex)
  hex = hex:gsub("#", "")

  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)

  local brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000
  return brightness > 155
end

function M.apply_theme(name)
  vim.o.background = "dark"
  vim.cmd.colorscheme(name)

  -- optional: auto-adjust after theme loads
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  if normal.bg then
    local hex = string.format("#%06x", normal.bg)
    vim.o.background = M.is_hex_color_light(hex) and "light" or "dark"
  end
end

return M

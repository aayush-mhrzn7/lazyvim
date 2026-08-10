local function hide_win_separators()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  local fg = normal.bg and string.format("#%06x", normal.bg) or "#1B1E28"

  -- Match separator color to background so the line disappears
  for _, group in ipairs({ "WinSeparator", "VertSplit", "SnacksWinSeparator" }) do
    vim.api.nvim_set_hl(0, group, { fg = fg, bg = "NONE" })
  end

  vim.opt.fillchars:append({
    vert = " ",
    horiz = " ",
    horizup = " ",
    horizdown = " ",
    vertleft = " ",
    vertright = " ",
    verthoriz = " ",
  })
end

return {
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = false,
      disable_float_background = false,
      disable_italics = false,
    },
    config = function(_, opts)
      require("poimandres").setup(opts)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "poimandres",
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Re-apply after theme/snacks highlights load
      vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter", "WinNew" }, {
        group = vim.api.nvim_create_augroup("hide_win_separators", { clear = true }),
        callback = function()
          vim.schedule(hide_win_separators)
        end,
      })
      vim.schedule(hide_win_separators)
      return opts
    end,
  },
}

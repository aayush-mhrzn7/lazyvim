-- Cmdline (:) suggestions via noice UI + blink.cmp
return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true, -- popup suggestions when typing :
        long_message_to_split = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      cmdline = {
        enabled = true,
        completion = {
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ":"
            end,
          },
          ghost_text = { enabled = true },
        },
      },
    },
  },
}

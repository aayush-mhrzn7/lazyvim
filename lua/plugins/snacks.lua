return {
  desc = "Snacks File Explorer + Right-Side Terminal",
  recommended = true,
  "folke/snacks.nvim",
  opts = {
    explorer = { hidden = true, ignored = true },
    picker = {
      hidden = true,
      ignored = true,
    },
    -- Disable LSP "same symbol" highlight (too loud on poimandres while typing)
    words = { enabled = false },
    terminal = {
      win = {
        position = "right", -- open terminal on the right
        -- width = 0.30,      -- optional: set width as percentage or number
      },
    },
  },

  keys = {
    -- Snacks Explorer (your original keys)
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },

    -- >>> OPTIONAL: Right-side terminal shortcut <<<
    {
      "<leader>t",
      function()
        Snacks.terminal(nil, { win = { position = "right" } })
      end,
      desc = "Terminal (right side)",
    },
  },
}

return {
  -- Better split navigation with tmux
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- Better buffer deletion (preserves window layout)
  {
    "ojroques/nvim-bufdel",
    config = function()
      require("bufdel").setup({
        next = "tabs",
        quit = false,
      })
    end,
  },
}

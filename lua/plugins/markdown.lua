return {
  {
    "LazyVim/LazyVim",
    keys = {
      {
        "<leader>i",
        'c*<C-r>"*<Esc>',
        mode = "v",
        desc = "Italic selection",
      },
      {
        "<leader>B",
        'c**<C-r>"**<Esc>',
        mode = "v",
        desc = "Bold selection",
      },
      {
        '<leader>"',
        'c"<C-r>""<Esc>',
        mode = "v",
        desc = "Double-quote selection",
      },
      {
        "<leader>'",
        [[c'<C-r>"'<Esc>]],
        mode = "v",
        desc = "Single-quote selection",
      },
      {
        "<leader>(",
        'c(<C-r>")<Esc>',
        mode = "v",
        desc = "Parenthesize selection",
      },
      {
        "<leader>{",
        'c{<C-r>"}<Esc>',
        mode = "v",
        desc = "Brace selection",
      },
      {
        "<leader>[",
        'c[<C-r>"]<Esc>',
        mode = "v",
        desc = "Bracket selection",
      },
    },
  },
}

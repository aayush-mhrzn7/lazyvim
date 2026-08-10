return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      }
      opts.current_line_blame_formatter = "<author>, <author_time:%R> · <summary>"

      local old_on_attach = opts.on_attach
      opts.on_attach = function(buffer)
        if old_on_attach then
          old_on_attach(buffer)
        end

        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "<leader>gbl", gs.toggle_current_line_blame, {
          buffer = buffer,
          desc = "Toggle Inline Git Blame",
        })
      end

      return opts
    end,
  },
  {
    "gitsigns.nvim",
    opts = function()
      Snacks.toggle({
        name = "Git Blame",
        get = function()
          return require("gitsigns.config").config.current_line_blame
        end,
        set = function(state)
          require("gitsigns").toggle_current_line_blame(state)
        end,
      }):map("<leader>ubl")
    end,
  },
}

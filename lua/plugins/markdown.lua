-- Relaxed markdownlint rules live next to this config.
local markdownlint_config = vim.fn.stdpath("config") .. "/.markdownlint.yaml"

return {
  -- Markdown: keep diagnostics as signs/underline only (no inline virtual text)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics = opts.diagnostics or {}
      local vt = opts.diagnostics.virtual_text
      if vt == false then
        return
      end
      vt = type(vt) == "table" and vt or {}
      local fmt = vt.format
      vt.format = function(d)
        local ok, ft = pcall(function()
          return vim.bo[d.bufnr].filetype
        end)
        if ok and (ft == "markdown" or ft == "markdown.mdx") then
          return nil -- hide inline text; sign + underline remain
        end
        return fmt and fmt(d) or d.message
      end
      opts.diagnostics.virtual_text = vt
    end,
  },

  -- Linter (nvim-lint): use the relaxed rule set
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", markdownlint_config, "-" },
        },
      },
    },
  },

  -- Preview: <leader>cp = rendered split inside Neovim, <leader>cP = browser
  {
    "MeanderingProgrammer/render-markdown.nvim",
    keys = {
      {
        "<leader>cp",
        "<cmd>RenderMarkdown preview<cr>",
        ft = { "markdown", "markdown.mdx" },
        desc = "Markdown Preview (split)",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<leader>cp", false, ft = "markdown" },
      {
        "<leader>cP",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview (browser)",
      },
    },
  },

  -- Formatter (conform --fix on save): same rule set
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", markdownlint_config },
        },
      },
    },
  },

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

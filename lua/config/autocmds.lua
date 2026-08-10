-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- in ~/.config/nvim/lua/config/autocmds.lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'vue', 'scss', 'css' },
  callback = function()
    local map = vim.keymap.set
    local opts = { buffer = true }  -- buffer-local only!

    -- Vue: delete surrounding tag, keep content
    map('n', '<leader>dt', 'dst', vim.tbl_extend('force', opts, { desc = 'Delete surrounding tag' }))

    -- SCSS: rename scoped class (prompts for old/new name)
    map('n', '<leader>rc', function()
      local old = vim.fn.input('Old class: ')
      local new = vim.fn.input('New class: ')
      vim.cmd(string.format("'a,'bs/%s/%s/g", old, new))
    end, vim.tbl_extend('force', opts, { desc = 'SCSS: rename class in marked block' }))

    -- CSS: hex color to variable
    map('n', '<leader>hv', function()
      local hex = vim.fn.input('Hex color: ')
      local var = vim.fn.input('Variable name: ')
      vim.cmd(string.format('%%s/%s/%s/g', hex, var))
    end, vim.tbl_extend('force', opts, { desc = 'CSS: hex to variable' }))
  end,
})


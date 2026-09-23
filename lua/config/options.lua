-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "unnamedplus"

-- fish sits in a different place per platform (Homebrew on Apple Silicon, Intel,
-- or Linux), so resolve it rather than hardcoding. If it is not found, keep the
-- default shell: a bad 'shell' breaks every :terminal, :! and plugin shell call.
local fish = vim.fn.exepath("fish")
if fish == "" then
  for _, candidate in ipairs({
    "/opt/homebrew/bin/fish",
    "/usr/local/bin/fish",
    "/usr/bin/fish",
  }) do
    if vim.fn.executable(candidate) == 1 then
      fish = candidate
      break
    end
  end
end

if fish ~= "" then
  vim.opt.shell = fish
  vim.opt.shellcmdflag = "-c"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

vim.opt.relativenumber = true

-- vim.g.mapleader = "\\"       -- Global leader key
-- vim.g.maplocalleader = "\\"  -- Local leader key

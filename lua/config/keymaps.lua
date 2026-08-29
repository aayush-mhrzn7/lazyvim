-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Better buffer deletion (nvim-bufdel keeps the window layout)
map("n", "<leader>bd", "<cmd>BufDel<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bo", "<cmd>BufDelOthers<cr>", { desc = "Delete Other Buffers" })
map("n", "<A-w>", "<cmd>BufDel<cr>", { desc = "Delete Active Buffer" })

-- macOS: Cmd (<D->) does what Ctrl (<C->) does on PC. Linux/Windows are unchanged.
if vim.fn.has("mac") == 1 then
  if vim.g.neovide then
    vim.g.neovide_input_use_logo = true
  end

  local modes = { "n", "i", "v", "x", "s", "o", "c", "t" }
  local function cmd_as_ctrl(key)
    vim.keymap.set(modes, "<D-" .. key .. ">", "<C-" .. key .. ">", {
      remap = true,
      silent = true,
      desc = "which_key_ignore",
    })
  end

  for c in ("abcdefghijklmnopqrstuvwxyz0123456789"):gmatch(".") do
    cmd_as_ctrl(c)
    cmd_as_ctrl("S-" .. c)
  end

  for _, key in ipairs({
    "/",
    "_",
    "-",
    "=",
    "[",
    "]",
    "\\",
    "'",
    ";",
    ",",
    ".",
    "`",
    "Left",
    "Right",
    "Up",
    "Down",
    "Space",
    "Tab",
    "BS",
    "CR",
    "PageUp",
    "PageDown",
    "Home",
    "End",
  }) do
    cmd_as_ctrl(key)
  end

  -- Mac-standard edit keys (these should not go through Ctrl)
  map("v", "<D-c>", '"+y', { desc = "Copy", silent = true })
  map("n", "<D-c>", '"+yy', { desc = "Copy Line", silent = true })
  map({ "n", "v" }, "<D-x>", '"+d', { desc = "Cut", silent = true })
  map({ "n", "v" }, "<D-v>", '"+P', { desc = "Paste", silent = true })
  map("i", "<D-v>", "<C-r>+", { desc = "Paste", silent = true })
  map("c", "<D-v>", "<C-r>+", { desc = "Paste", silent = true })
  map("t", "<D-v>", [[<C-\><C-n>"+pi]], { desc = "Paste", silent = true })
  map({ "n", "v" }, "<D-z>", "u", { desc = "Undo", silent = true })
  map("i", "<D-z>", "<C-o>u", { desc = "Undo", silent = true })
  map({ "n", "i", "v" }, "<D-S-z>", "<C-r>", { desc = "Redo", silent = true })
  map("n", "<D-a>", "ggVG", { desc = "Select All", silent = true })
  map("i", "<D-a>", "<Esc>ggVG", { desc = "Select All", silent = true })
end

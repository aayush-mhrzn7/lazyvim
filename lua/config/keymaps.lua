-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Better buffer deletion (nvim-bufdel keeps the window layout)
map("n", "<leader>bd", "<cmd>BufDel<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bo", "<cmd>BufDelOthers<cr>", { desc = "Delete Other Buffers" })
map("n", "<A-w>", "<cmd>BufDel<cr>", { desc = "Delete Active Buffer" })

-- Split while inside a terminal buffer (<C-w>s/<C-w>v are normally swallowed
-- by the shell in terminal mode since it's insert-like). Leaves terminal
-- mode, splits, opens a fresh terminal in the new split, and re-enters it.
-- Both the plain and Ctrl-held second key work (<C-w>s and <C-w><C-s>) since
-- macOS Cmd is remapped to Ctrl above, and Cmd+w Cmd+s sends <C-w><C-s>.
map("t", "<C-w>s", [[<C-\><C-n><C-w>s<cmd>terminal<cr>i]], { desc = "Split Terminal Below" })
map("t", "<C-w><C-s>", [[<C-\><C-n><C-w>s<cmd>terminal<cr>i]], { desc = "Split Terminal Below" })
map("t", "<C-w>v", [[<C-\><C-n><C-w>v<cmd>terminal<cr>i]], { desc = "Split Terminal Right" })
map("t", "<C-w><C-v>", [[<C-\><C-n><C-w>v<cmd>terminal<cr>i]], { desc = "Split Terminal Right" })

-- :Search !g <query> / :Search !gpt <query> -- DuckDuckGo-style "!bang" web
-- search. No bang given defaults to Google. Add more engines to the table.
local search_engines = {
  g = "https://www.google.com/search?q=",
  gpt = "https://chatgpt.com/?q=",
}
local default_bang = "g"

local function url_encode(str)
  return (str:gsub("[^%w%-%.%_%~]", function(c)
    return string.format("%%%02X", c:byte())
  end))
end

vim.api.nvim_create_user_command("Search", function(opts)
  local bang, query = opts.args:match("^!(%S+)%s+(.*)$")
  if not bang then
    bang, query = default_bang, opts.args
  end
  local base = search_engines[bang]
  if not base then
    vim.notify("Search: unknown bang '!" .. bang .. "'", vim.log.levels.ERROR)
    return
  end
  vim.ui.open(base .. url_encode(query))
end, { nargs = "+", desc = "Web search with !bang, e.g. !g, !gpt" })

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

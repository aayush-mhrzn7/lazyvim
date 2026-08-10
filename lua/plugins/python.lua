-- Point pyright at the project-local venv/.venv so imports resolve.
local function python_path(root_dir)
  for _, name in ipairs({ ".venv", "venv" }) do
    local candidate = root_dir .. "/" .. name .. "/bin/python"
    if vim.uv.fs_stat(candidate) then
      return candidate
    end
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
          on_new_config = function(config, root_dir)
            local py = python_path(root_dir)
            if not py then
              return
            end
            config.settings = config.settings or {}
            config.settings.python = config.settings.python or {}
            config.settings.python.pythonPath = py
          end,
        },
      },
    },
  },
}

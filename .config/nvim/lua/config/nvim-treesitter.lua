local M = {}

function M.setup()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  treesitter.setup {
    ensure_installed = {
      "bash",
      "go",
      "graphql",
      "html",
      "javascript",
      "json",
      "lua",
      "python",
      "ruby",
      "solidity",
      "typescript",
      "yaml",
    },
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      -- dont enable this, messes up python indentation
      enable = false,
      disable = {},
    },
  }

end

return M

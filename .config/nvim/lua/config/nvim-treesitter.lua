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
      disable = { "" },
      additional_vim_regex_highlighting = false,
    },
    indent = {
      -- dont enable this, messes up python indentation
      enable = false,
      disable = {},
    },
  }

  -- vim.opt.foldmethod     = 'expr'
  -- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  ---WORKAROUND
  vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
      vim.opt.foldmethod     = 'expr'
      vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    end
  })
  ---ENDWORKAROUND
end

return M

local M = {}

function M.setup()
  -- Basic configuration (optional)
  vim.g.opencode_opts = {
    -- your settings here
  }

  -- Optional: keymaps
  vim.keymap.set({ "n", "x" }, "<C-a>", function()
    require("opencode").ask("@this: ", { submit = true })
  end, { desc = "Ask opencode" })

  vim.keymap.set({ "n", "x" }, "<C-x>", function()
    require("opencode").select()
  end, { desc = "Opencode select" })

  vim.keymap.set("n", "<C-.>", function()
    require("opencode").toggle()
  end, { desc = "Toggle opencode" })

  vim.o.autoread = true
end

return M

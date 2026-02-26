local M = {}

function M.setup()
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
end

return M

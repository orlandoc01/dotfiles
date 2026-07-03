# TODO

## Neovim: Switch to native multi-source autocomplete

Once [neovim/neovim#35470](https://github.com/neovim/neovim/issues/35470) (autocomplete eats first char) is fixed, update `.config/nvim/lua/config/lsp.lua`:

1. Remove the entire `LspAttach` autocmd block (the `vim.lsp.completion.enable()` call, the `convert` snippet filter, and the `InsertCharPre` keyword trigger)

2. Replace it with:
```lua
vim.o.autocomplete = true
vim.o.complete = '.,w,b,o'
```

3. Keep the existing `completeopt` line as-is

This merges buffer words + LSP into a single auto-triggered popup, replacing the current approach of LSP-only popup + manual keyword triggering.

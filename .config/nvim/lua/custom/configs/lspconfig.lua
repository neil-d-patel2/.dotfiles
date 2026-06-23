-- Custom LSP servers, layered on top of NvChad's defaults.
-- Reuses NvChad's on_attach / capabilities / on_init so keymaps,
-- signature help and semantic-token handling stay consistent.

local base = require "plugins.configs.lspconfig"

-- LSP servers to configure. Names must match nvim-lspconfig server names.
-- (Install the matching Mason packages via :MasonInstallAll — see custom/plugins.lua)
local servers = { "pyright", "clangd" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = base.on_attach,
    on_init = base.on_init,
    capabilities = base.capabilities,
  })
  vim.lsp.enable(lsp)
end

-- Diagnostics are still computed by the LSP, but NOT shown inline (no virtual
-- text, gutter signs, or underlines). View them on demand via Trouble: <leader>xx
vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  underline = false,
  update_in_insert = false,
}

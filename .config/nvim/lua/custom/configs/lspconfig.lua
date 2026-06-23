-- Custom LSP servers, layered on top of NvChad's defaults.
-- Reuses NvChad's on_attach / capabilities / on_init so keymaps,
-- signature help and semantic-token handling stay consistent.

local base = require "plugins.configs.lspconfig"

-- LSP servers to configure. Names must match nvim-lspconfig server names.
-- (Install the matching Mason packages via :MasonInstallAll — see custom/plugins.lua)
-- Per-server `settings` are merged on top of the shared NvChad base config.
-- pyright and clangd intentionally removed. pyright attached to every .py and
-- published diagnostics ("Expression value is unused") whose inline rendering
-- froze the UI for ~5-10s on open; clangd removed by request too. No custom LSP
-- servers are configured now (NvChad's default lua_ls still applies to Lua).
local servers = {}

for lsp, extra in pairs(servers) do
  vim.lsp.config(lsp, vim.tbl_deep_extend("force", {
    on_attach = base.on_attach,
    on_init = base.on_init,
    capabilities = base.capabilities,
  }, extra))
  vim.lsp.enable(lsp)
end

-- Diagnostics are shown inline (virtual text, gutter signs, underlines).
-- Not updated while typing, to avoid noise mid-edit.
vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
}

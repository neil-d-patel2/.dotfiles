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

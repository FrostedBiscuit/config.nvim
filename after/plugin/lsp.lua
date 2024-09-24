local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'rust_analyzer',
	'texlab',
	'denols',
	'emmet_language_server'
})

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({buffer = bufnr})

	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)

	vim.keymap.set("i", "<C- >", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').gdscript.setup({})
require('lspconfig').texlab.setup({})
require('lspconfig').denols.setup({
	on_attach = lsp.on_attach,
	root_dir = require('lspconfig').util.root_pattern("deno.json", "deno.jsonc")
})
require('lspconfig').emmet_language_server.setup({})

require("mason").setup()

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
cmp.setup({
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
	},
})

lsp.setup()

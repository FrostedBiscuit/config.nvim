local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
	'ts_ls',
	'eslint',
	'rust_analyzer',
	'texlab',
	'denols',
	'emmet_language_server'
})

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)

	vim.keymap.set("i", "<C- >", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.gdscript.setup({})
lspconfig.texlab.setup({})
lspconfig.ts_ls.setup({
	root_dir = lspconfig.util.root_pattern("package.json"),
	single_file_support = false
})
lspconfig.denols.setup({
	root_dir = lspconfig.util.root_pattern("deno.json"),
	init_options = {
		lint = true,
		unstable = true,
		suggest = {
			imports = {
				hosts = {
					["https://deno.land"] = true,
					["https://cdn.nest.land"] = true,
					["https://crux.land"] = true,
				},
			},
		},
	},
	on_attach = function()
		local active_clients = vim.lsp.get_active_clients()
		for _, client in pairs(active_clients) do
			-- stop tsserver if denols is already active
			if client.name == "tsserver" then
				client.stop()
			end
		end
	end,
})
lspconfig.emmet_language_server.setup({})

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

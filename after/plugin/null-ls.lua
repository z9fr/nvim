local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

local null_ls = require("null-ls")

-- register any number of sources simultaneously
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting
local sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.code_actions.gitsigns
}

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm",
                                    "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
    end
})

null_ls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd(
                "nnoremap <silent><buffer> <Leader>ff :lua vim.lsp.buf.format { async = true }<CR>")

            -- format on save
            vim.cmd(
                "autocmd BufWritePost <buffer> lua vim.lsp.buf.format { async = true }")
        end

        if client.server_capabilities.documentRangeFormattingProvider then
            vim.cmd(
                "xnoremap <silent><buffer> <Leader>ff :lua vim.lsp.buf.range_formatting({})<CR>")
        end
    end
})

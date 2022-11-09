local Remap = require("dasith.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local sumneko_root_path =
    "/opt/git-clones/lua-language-server/bin/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local cmp = require("cmp")
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]"
}

local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `vsnip` user.
            -- vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` user.
            require("luasnip").lsp_expand(args.body)

            -- For `ultisnips` user.
            -- vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({select = true}), -- ctrl + y will  autocomplete
        ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- ctrl + u will scroll down on docs
        ["<C-d>"] = cmp.mapping.scroll_docs(4), -- ctrl + d will go sctroll up on docs
        ["<C-Space>"] = cmp.mapping.complete()
    }),

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and
                    entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end
    },

    sources = {
        -- tabnine completion? yayaya

        {name = "cmp_tabnine"}, {name = "nvim_lsp"}, -- For vsnip user.
        -- { name = 'vsnip' },
        -- For luasnip user.
        {name = "luasnip"}, -- For ultisnips user.
        -- { name = 'ultisnips' },
        {name = "buffer"}
    }
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = ".."
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = function()
            nnoremap("gd", function() vim.lsp.buf.definition() end) -- gd go to definition
            nnoremap("K", function() vim.lsp.buf.hover() end) -- view description 
            nnoremap("<leader>vws",
                     function() vim.lsp.buf.workspace_symbol() end)
            nnoremap("<leader>vd", function()
                vim.diagnostic.open_float()
            end)
            nnoremap("[d", function() vim.diagnostic.goto_next() end)
            nnoremap("]d", function() vim.diagnostic.goto_prev() end)
            nnoremap("<leader>vca", function()
                vim.lsp.buf.code_action()
            end)
            nnoremap("<leader>vco", function()
                vim.lsp.buf.code_action({
                    filter = function(code_action)
                        if not code_action or not code_action.data then
                            return false
                        end

                        local data = code_action.data.id
                        return string.sub(data, #data - 1, #data) == ":0"
                    end,
                    apply = true
                })
            end)
            nnoremap("<leader>vrr", function()
                vim.lsp.buf.references()
            end)
            nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
            inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
        end
    }, _config or {})
end

require("lspconfig").zls.setup(config())
require("lspconfig").tsserver.setup(config())
require("lspconfig").ccls.setup(config())
require("lspconfig").jedi_language_server.setup(config())
require("lspconfig").solang.setup(config())
require("lspconfig").cssls.setup(config())
require("lspconfig").phpactor.setup(config())

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
    local plugins = {"friendly-snippets"}
    local paths = {}
    local path
    local root_path = vim.env.HOME .. "/.vim/plugged/"
    for _, plug in ipairs(plugins) do
        path = root_path .. plug
        if vim.fn.isdirectory(path) ~= 0 then table.insert(paths, path) end
    end
    return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {}
})

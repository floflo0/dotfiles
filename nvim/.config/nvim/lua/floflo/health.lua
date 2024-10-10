local EXTERNAL_DEPENDENCIES = {
    'fd',

    -- Lsp
    'pylsp',
    'bash-language-server',
    'fish-lsp',
    'tsserver',
    'vscode-html-language-server',
    'vscode-css-language-server',
    'vscode-json-language-server',
    'vscode-eslint-language-server',
    'vue-language-server',
    'tailwindcss-language-server',
    'clangd',
    'glsl_analyzer',
    'rust-analyzer',
    'gopls',
    'lua-language-server',
    'intelephense',
    'marksman',
    'jdtls',
    'cmake-language-server',
    'ocamllsp',
    'solargraph',
}

local function check_external_dependencies()
    vim.health.start('Checking external dependencies')
    for _, dependency in pairs(EXTERNAL_DEPENDENCIES) do
        if vim.fn.executable(dependency) == 1 then
            vim.health.ok(dependency .. ' installed')
        else
            vim.health.error(dependency .. ' not found')
        end
    end
end

local M = {}

M.check = function()
    check_external_dependencies()
end

return M

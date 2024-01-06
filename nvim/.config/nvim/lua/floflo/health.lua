local DEPENDENCIES = {
    'exa',
    'fdfind',

    -- Lsp
    'pylsp',
    'bash-language-server',
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
    'jdtls'
}

local M = {}

M.check = function()
    vim.health.report_start('Checking config dependencies')
    for _, dependency in pairs(DEPENDENCIES) do
        if vim.fn.executable(dependency) == 1 then
            vim.health.report_ok(dependency .. ' installed')
        else
            vim.health.report_error(dependency .. ' not found')
        end
    end

end

return M

local EXTERNAL_DEPENDENCIES = {
    'fd',
    'ktlint',

    -- Lsp
    'lua-language-server',
    'clangd',
    'cmake-language-server',
    'glsl_analyzer',
    'vscode-html-language-server',
    'emmet-language-server',
    'vscode-css-language-server',
    'vscode-json-language-server',
    'yaml-language-server',
    'vscode-eslint-language-server',
    'vtsls',
    'vue-language-server',
    'tailwindcss-language-server',
    'ngserver',
    'pylsp',
    'bash-language-server',
    'fish-lsp',
    'rust-analyzer',
    'gopls',
    'intelephense',
    'jdtls',
    'kotlin-language-server',
    'gradle-language-server',
    'ansible-language-server',
    'tinymist',
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

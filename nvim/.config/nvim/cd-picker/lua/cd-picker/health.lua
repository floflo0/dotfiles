local PLUGIN_DEPENDENCIES = {
    'telescope'
}

local EXTERNAL_DEPENDENCIES = {
    'exa',
    'fdfind'
}

local function check_plugin_dependencies()
    vim.health.start('Checking plugin dependencies')
    for _, dependency in pairs(PLUGIN_DEPENDENCIES) do
        local has_plugin, _ = pcall(require, dependency)
        if has_plugin then
            vim.health.ok(dependency .. ' installed')
        else
            vim.health.error(dependency .. ' not found')
        end

    end
end

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
    check_plugin_dependencies()
    check_external_dependencies()
end

return M

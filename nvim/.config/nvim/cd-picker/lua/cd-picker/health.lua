local DEPENDENCIES = {
    'exa',
    'fdfind'
}

local M = {}

M.check = function()
    vim.health.report_start('Checking cd-picker dependencies')
    for _, dependency in pairs(DEPENDENCIES) do
        if vim.fn.executable(dependency) == 1 then
            vim.health.report_ok(dependency .. ' installed')
        else
            vim.health.report_error(dependency .. ' not found')
        end
    end
end

return M

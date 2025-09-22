return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            kotlin = { 'ktlint' },
        },
    },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format(
                    {
                        timeout_ms = 10000,
                    },
                    function(err)
                        if err ~= nil then
                            vim.notify(err, vim.log.levels.ERROR)
                        else
                            vim.notify(' Formatting completed ✔️')
                        end
                    end
                )
            end,
            mode = { 'n', 'v' },
            desc = 'Format file',
        },
    },
}

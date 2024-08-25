local has_telescope, _ = pcall(require, 'telescope')

if not has_telescope then
    error('This plugin requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)')
end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values

local ROOT = os.getenv('HOME')
local PREVIEW_DEPTH = 5

return function()
    local previewer = previewers.new_termopen_previewer({
        get_command = function(entry)
            return {
                'eza',
                '--tree',
                '--group-directories-first',
                '--icons',
                '--level', PREVIEW_DEPTH,
                '--ignore-glob=node_modules|__pycache__|vendor',
                vim.fs.joinpath(ROOT, entry.value)
            }
        end,
    })

    pickers.new({}, {
        prompt_title = 'Change Directory',
        finder = finders.new_oneshot_job({
            'fd',
            '--type',
            'directory',
            '--strip-cwd-prefix',
            '--base-directory', ROOT
        }, {}),
        previewer = previewer,
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local path = vim.fs.joinpath(ROOT, selection[1])
                vim.cmd.cd(path)
                vim.cmd.edit('.')
                vim.print(path)
            end)
            return true
        end
    }):find()
end

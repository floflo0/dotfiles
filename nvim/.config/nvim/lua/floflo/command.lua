local MODELS = vim.fs.joinpath(os.getenv('HOME'), 'Modèles')

local function exists(file, path)
    return #vim.fs.find(file, {
        path = path,
        limit = 1,
        type = 'file'
    }) == 1
end

vim.api.nvim_create_user_command('Model', function(command)
    local file_path = vim.fs.joinpath(MODELS, command.args)
    if not exists(command.args, MODELS) then
        vim.print('error: ' .. file_path  .. ' doesn\'t exists')
        return
    end

    if exists(command.args, '.') and not command.bang then
        vim.print('error: ' .. command.args .. ' already exists')
        return
    end

    local process = vim.system({
        'cp', file_path, command.args
    }, { text = true }):wait()

    if process.code ~= 0 then
        if process.stdout ~= '' then
            vim.print(process.stdout.sub(process.stdout, 1, #process.stdout - 1))
        end
        if process.stderr ~= '' then
            vim.print(process.stderr.sub(process.stderr, 1, #process.stderr - 1))
        end
        return
    end

    vim.cmd('e ' .. command.args)
end, {
    bang = true,
    nargs = 1,
    desc = 'Create file from models',
    complete = function ()
        vim.print('call')
        local process = vim.system({
            'fdfind',
            '--type',
            'file',
            '--strip-cwd-prefix',
            '--base-directory',
            MODELS
        }, { text = true }):wait()
        return vim.split(process.stdout, '\n', { trimempty = true })
    end
})

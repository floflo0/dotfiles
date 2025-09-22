if not vim.g.neovide then
    return
end

local FLOATING_BLUR = 4.0
local DEFAULT_SCALE_FACTOR = 1.0
local DELTA_SCALE_FACTOR = 0.05
local PADDING = 3  -- px

vim.g.neovide_opacity = 0.9
vim.g.neovide_floating_blur_amount_x = FLOATING_BLUR
vim.g.neovide_floating_blur_amount_y = FLOATING_BLUR

vim.opt.pumblend = 80
vim.opt.winblend = 80

vim.g.neovide_scale_factor = DEFAULT_SCALE_FACTOR

local set_scale_factor = function(scale_factor)
    vim.g.neovide_scale_factor = scale_factor
    vim.cmd.redraw({ bang = true })
end

local change_scale_factor = function(delta)
    set_scale_factor(vim.g.neovide_scale_factor + delta)
end

vim.keymap.set('n', '<C-=>', function() change_scale_factor(DELTA_SCALE_FACTOR) end,  { desc = 'Neovide: reset scale' })
vim.keymap.set('n', '<C-->', function() change_scale_factor(-DELTA_SCALE_FACTOR) end, { desc = 'Neovide: zoom out' })
vim.keymap.set('n', '<C-à>', function() set_scale_factor(DEFAULT_SCALE_FACTOR) end,   { desc = 'Neovide: zoom in' })

vim.g.neovide_padding_top = PADDING
vim.g.neovide_padding_bottom = PADDING
vim.g.neovide_padding_right = PADDING
vim.g.neovide_padding_left = PADDING

vim.g.neovide_hide_mouse_when_typing = true

vim.keymap.set({ 'i', 'c' }, '<C-S-v>', '<C-r>+')

vim.g.terminal_color_0 = '#494d64'
vim.g.terminal_color_1 = '#ed8796'
vim.g.terminal_color_2 = '#a6da95'
vim.g.terminal_color_3 = '#eed49f'
vim.g.terminal_color_4 = '#8aadf4'
vim.g.terminal_color_5 = '#f5bde6'
vim.g.terminal_color_6 = '#8bd5ca'
vim.g.terminal_color_7 = '#b8c0e0'
vim.g.terminal_color_8 = '#5b6078'
vim.g.terminal_color_9 = '#ed8796'
vim.g.terminal_color_10 = '#a6da95'
vim.g.terminal_color_11 = '#eed49f'
vim.g.terminal_color_12 = '#8aadf4'
vim.g.terminal_color_13 = '#f5bde6'
vim.g.terminal_color_14 = '#8bd5ca'
vim.g.terminal_color_15 = '#a5adcb'

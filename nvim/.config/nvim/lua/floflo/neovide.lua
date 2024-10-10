if not vim.g.neovide then
    return
end

local FLOATING_BLUR = 1.0
local DEFAULT_SCALE_FACTOR = 1.0
local DELTA_SCALE_FACTOR = 0.05
local PADDING = 3  -- px

vim.g.neovide_transparency = 0.9
vim.g.neovide_floating_blur_amount_x = FLOATING_BLUR
vim.g.neovide_floating_blur_amount_y = FLOATING_BLUR

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

-- vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+')
vim.keymap.set({ 'i', 'c' }, '<C-S-v>', '<C-r>+')

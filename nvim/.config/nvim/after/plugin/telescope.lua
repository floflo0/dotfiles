-- $ sudo pacman -S rirep
-- $ sudo pacman -S fd

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup({})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

return {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
        filetypes = { 'html', 'css', 'scss', 'js', 'jsx', 'ts', 'tsx', 'vue' },
        user_default_options = {
            RGB = true,
            RRGGBB = true,
            names = true,
            RRGGBBAA = true,
            AARRGGBB = true,
            rgb_fn = true,
            hsl_fn = true,
            css = true,
            css_fn = true,
            mode = 'background',
            tailwind = true,
            sass = { enable = false, parsers = { 'css' } },
            virtualtext = ' ■',
            always_update = false,
        },

        buftypes = {},
    },
}

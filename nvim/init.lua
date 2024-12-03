-- Load Packer
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'  -- Packer can manage itself

    -- Essential Plugins
    use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
    use 'neovim/nvim-lspconfig'     -- LSP configurations
    use 'hrsh7th/nvim-cmp'          -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'      -- LSP source for nvim-cmp
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }  -- Treesitter for better syntax highlighting

    -- Snippet Plugins
    use 'hrsh7th/vim-vsnip'         -- Snippet engine
    use 'hrsh7th/cmp-vsnip'         -- Snippet completion source for nvim-cmp

    -- Additional Completion Sources
    use 'hrsh7th/cmp-buffer'        -- Buffer completions
    use 'hrsh7th/cmp-path'          -- Path completions

    -- UI Plugins
    use 'nvim-lualine/lualine.nvim' -- Status line
    use 'chrisbra/csv.vim'          -- CSV plugin
    use 'sbdchd/neoformat'
    use 'Xemptuous/sqlua.nvim'
    -- File Navigation
    use {
      'nvim-tree/nvim-tree.lua',   -- File explorer
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
    }

    -- Git Integration
    use 'tpope/vim-fugitive'        -- Git commands in nvim
    use 'lewis6991/gitsigns.nvim'   -- Git signs in the gutter

    -- Tmux Integration
    use 'christoomey/vim-tmux-navigator' -- Seamless navigation between tmux panes and vim splits

    -- Commenting
    use 'numToStr/Comment.nvim'

    -- Better file searching
    use 'BurntSushi/ripgrep'

    -- Color schemes
    use 'folke/tokyonight.nvim'

    -- Improve startup time
    use 'lewis6991/impatient.nvim'

    -- Terminal integration
    use {"akinsho/toggleterm.nvim", tag = '*'}
end)

-- Set leader key to space
vim.g.mapleader = " "

-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Enable Lualine (status line)
local status_ok, lualine = pcall(require, 'lualine')
if status_ok then
    lualine.setup()
end

-- NvimTree Setup
local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if status_ok then
    nvim_tree.setup({
        filters = {
            dotfiles = false,  -- Show dotfiles
            custom = {},       -- No custom filters
        },
        git = {
            enable = true,     -- Enable Git integration
            ignore = false,    -- Show files ignored by Git
        },
    })
end

-- NvimTree Key Binding
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Setup Telescope
local status_ok, telescope = pcall(require, 'telescope')
if status_ok then
    telescope.setup()
end

-- Telescope Key Bindings
vim.api.nvim_set_keymap('n', '<Leader>ff', "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })

-- Reload Config Command
vim.api.nvim_create_user_command('ReloadConfig', 'source ~/.config/nvim/init.lua', {})

-- Treesitter Configuration
require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "sql", "go", "typescript", "python", "bash" },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true },
}

-- LSP and Autocompletion Setup
-- TypeScript Server
require('lspconfig').ts_ls.setup{}

-- Lua LSP (for Neovim development)
require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}

-- Python LSP
require('lspconfig').pyright.setup{}

-- nvim-cmp Setup
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)  -- For `vim-vsnip` users
        end,
    },
    mapping = {
        -- Define your key mappings for completion here (optional)
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },  -- For vsnip users
    }, {
        { name = 'buffer' },
        { name = 'path' },
    })
})

-- Use buffer source for `/` and `?` (if you want)
cmp.setup.cmdline({ '/', '?' }, {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Diagnostics Configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
})

-- Comment.nvim setup
require('Comment').setup()

-- Toggleterm setup
require("toggleterm").setup{
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = '1',
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved',
        winblend = 3,
    }
}

-- Load impatient.nvim to improve startup time
require('impatient')

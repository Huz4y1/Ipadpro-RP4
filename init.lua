-- =========================================
-- Neovim init.lua for iPad / Pi Friendly
-- Includes lots of themes, keybinds, and folder management
-- =========================================

-- Packer bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- ====================
  -- THEMES
  -- ====================
  -- Dark / Classic
  use 'morhetz/gruvbox'
  use 'dracula/vim'
  use 'shaunsingh/nord.nvim'
  use 'sainnhe/everforest'
  use 'folke/tokyonight.nvim'
  use 'rose-pine/neovim'
  use 'EdenEast/nightfox.nvim'
  use 'arcticicestudio/nord-vim'
  use 'mhartington/oceanic-next'
  use 'tomasiser/vim-code-dark'
  use {'catppuccin/nvim', as = 'catppuccin'}

  -- Light / Pastel / Soft
  use 'sainnhe/sonokai'
  use 'ayu-theme/ayu-vim'
  use 'lifepillar/vim-solarized8'
  use 'liuchengxu/space-vim-theme'
  use 'marko-cerovac/material.nvim'
  use 'savq/melange'
  use 'cocopon/iceberg.vim'
  use 'tanvirtin/monokai.nvim'
  use 'navarasu/onedark.nvim'

  use 'tomasr/molokai'                    -- Molokai
  use 'sjl/gundo.vim'                     -- Gundo colors
  use 'arzg/vim-colors-xcode'             -- Xcode colors
  use 'rakr/vim-one'                      -- One theme
  use 'sainnhe/sonokai'                   -- Sonokai (minimal)
  use 'lifepillar/vim-solarized8'         -- Solarized8 (minimal)
  use 'navarasu/onedark.nvim'             -- One Dark

  -- Fun / vibrant
  use 'dracula/vim'                       -- Dracula
  use 'Yazeed1s/minimal.nvim'             -- Minimal, modern
  use 'tanvirtin/monokai.nvim'            -- Monokai
  use 'savq/melange'                      -- Melange
  use 'cocopon/iceberg.vim'               -- Iceberg

  -- Folder/file manager
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lua/plenary.nvim'

end)

-- ====================
-- OPTIONS
-- ====================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

-- ====================
-- KEYBINDS
-- ====================
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- File explorer toggle
map('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
-- Splits
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
-- Save and quit
map('n', '<C-s>', ':w<CR>', opts)
map('n', '<C-q>', ':q<CR>', opts)
-- Telescope if installed
map('n', '<C-p>', ':Telescope find_files<CR>', opts)

-- ====================
-- NVIMTREE SETUP
-- ====================
require'nvim-tree'.setup {
  view = {
    width = 30,
    side = 'left',
    number = true,
    relativenumber = true,
  },
  git = {
    enable = true,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    }
  },
}

-- ====================
-- COLORSCHEMES
-- ====================
-- Default to Catppuccin
vim.cmd [[colorscheme catppuccin]]

-- To switch: e.g., :colorscheme gruvbox
-- Or add your favorite from the packer list above


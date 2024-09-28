set number
set shiftwidth=2
set smartindent
set smarttab
set icon

" Reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_

" Plugins
call plug#begin()
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'navarasu/onedark.nvim'

  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'romgrk/barbar.nvim'
  Plug 'nvim-tree/nvim-tree.lua'

  Plug 'github/copilot.vim'
  Plug 'preservim/nerdtree'
call plug#end()

" Theme
let g:onedark_config = {
  \ 'style': 'darker',
\}
colorscheme onedark

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" BufferTabs
nnoremap <C-[> :BufferPrevious<CR>
nnoremap <C-]> :BufferNext<CR>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


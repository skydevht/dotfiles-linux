call plug#begin()

" Language
Plug 'sheerun/vim-polyglot'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'dart-lang/dart-vim-plugin'
Plug 'w0rp/ale'
" Integration
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'Shougo/denite.nvim'
" Completion
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'wesQ3/vim-windowswap'
" Commands
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'godlygeek/tabular'
" Other
" Code Display
Plug 'skydevht/palenight.vim'
Plug 'jacoborus/tender.vim'
Plug 'chrisbra/Colorizer'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Leader
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Search
map <space> /
map <c-space> ?
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Terminal
if has('nvim')
    nnoremap <leader>` :te<CR>
    " tnoremap <ESC> <c-\><c-n>
    tnoremap <C-j> <c-\><c-n><C-W>j
    tnoremap <C-k> <c-\><c-n><C-W>k
    tnoremap <C-h> <c-\><c-n><C-W>h
    tnoremap <C-l> <c-\><c-n><C-W>l
endif

" Windows
noremap <leader>h <C-w>s
noremap <leader>v <C-w>v
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Buffers
noremap <leader>bq :q<cr>
map <leader>bd :Bclose<cr>
map <leader>ba :bufdo bd<cr>

" Tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
noremap <S-l> gt
noremap <S-h> gT
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"" No arrow
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Git
nmap <leader>gs :Gstatus<CR>
nmap <leader>ga :Git add -A<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gpl :Gpull<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>

" NERDTree
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" Function keys
noremap <F3> :ALEFix<CR>
noremap <F5> :source $HOME/.config/nvim/init.vim<CR>
nnoremap <F10> :e $MYVIMRC<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"

" COC
nmap <silent> <leader>rg <Plug>(coc-definition)
nmap <silent> <leader>rr <Plug>(coc-references)
nmap <silent> <leader>ri <Plug>(coc-implementation)
nmap <silent> <leader>rd <Plug>(coc-diagnostic-info)
nmap <silent> <leader>rn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>rp <Plug>(coc-diagnostic-prev)

" DENITE
nmap <leader>db :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>df :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>dg :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>dj :<C-u>DeniteCursorWord grep:.<CR>
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> <C-t>
                \ denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> <C-v>
                \ denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <C-h>
                \ denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> yy
                \ denite#do_map('do_action', 'yank')
    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
    nnoremap <silent><buffer><expr> <C-x>
                \ denite#do_map('choose_action')
    nnoremap <silent><buffer><expr><nowait> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    inoremap <silent><buffer><expr> <C-c>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-c>
                \ denite#do_map('quit')
endfunction

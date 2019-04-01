" Colorscheme
" Italics for my favorite color scheme
let g:palenight_terminal_italics=1
let g:material_terminal_italics=1
set background=dark
"let g:material_theme_style = 'palenight'
colorscheme tender
" Custom highlight
hi jsClassDefinition gui=bold
hi jsFuncArgs gui=italic
let g:javascript_plugin_flow = 1
" hi Normal guibg=NONE ctermbg=NONE
" hi NonText guibg=NONE ctermbg=NONE
" Airlines 
" let g:airline_powerline_fonts = 1
"let g:airline#extensions#tagbar#enabled = 0
" let g:airline#extensions#ale#enabled = 1
" let g:airline_theme = 'material'
" LightLine
let g:lightline = {
            \ 'colorscheme': 'tender',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightlineFugitive',
            \   'filename': 'LightlineFilename'
            \ }
            \ }
function! LightlineModified()
    return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
endfunction
function! LightlineFilename()
    return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction
function! LightlineFugitive()
    if &ft !~? 'vimfiler' && exists('*fugitive#head')
        return fugitive#head()
    endif
    return ''
endfunction

" FZF
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" Emmet
let g:user_emmet_settings = {
            \ 'javascript.jsx' : {
            \     'extends' : 'jsx',
            \ },
            \ }

" Ale
let g:ale_completion_enabled = 0
let g:ale_php_phpcbf_executable = '/home/hash/.config/composer/vendor/bin/phpcbf'
let g:ale_php_phpcs_executable = '/home/hash/.config/composer/vendor/bin/phpcs'
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcbf_standard = g:ale_php_phpcs_standard
let g:ale_javascript_prettier_executable = '/home/hash/.yarn/bin/prettier'
let g:ale_linters = { 
            \   'php': ['phpcs'],
            \   'dart': ['dartanalyzer'],
            \   'javascript': ['flow', 'eslint'],
            \   'typescript': ['tsserver'],
            \}
let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \   'perl': ['perl'],
            \   'php': ['phpcbf'],
            \   'json': ['jq'],
            \   'scss': ['prettier'],
            \   'css': ['prettier'],
            \   'html': ['prettier'],
            \   'dart': ['dartfmt'],
            \   'typescript': ['prettier'],
            \}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
" call Base16hi("ALEWarningSign", g:base16_gui0A, "", "", "")
" call Base16hi("ALEErrorSign", g:base16_gui08, "", "", "")
let g:ale_fix_on_save = 1
" AutoPairs
let g:AutoPairsMapSpace = 0

" Deoplete 
call deoplete#custom#source('file', 'rank', 50)
" call deoplete#custom#var('file', 'enable_buffer_path', 1)
" let g:deoplete#file#enable_buffer_path=1
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif" omnifuncs

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

augroup omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    "autocmd FileType html,markown setlocal omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
autocmd BufNewFile,BufRead *.tern-project set filetype=json
"autocmd BufNewFile,BufRead *.js set filetype=javascript.jsx
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
autocmd Filetype pug setlocal ts=2 sts=2 sw=2

" VIM LSP
let g:lsp_diagnostics_enabled = 0
if executable('javascript-typescript-stdio')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'javascript-typescript-stdio',
        \ 'cmd': {server_info->['javascript-typescript-stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
        \ })
endif
if executable('dart_language_server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'dart-language-server',
        \ 'cmd': {server_info->['dart_language_server']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'pubspec.yaml'))},
        \ 'whitelist': ['dart'],
        \ })
endif

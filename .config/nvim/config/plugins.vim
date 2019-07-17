" Colorscheme
" Italics for my favorite color scheme
let g:palenight_terminal_italics=1
let g:material_terminal_italics=1
set background=dark
"let g:material_theme_style = 'palenight'
colorscheme palenight
" Custom highlight
hi jsClassDefinition gui=bold
hi jsFuncArgs gui=italic
let g:javascript_plugin_flow = 1
" hi Normal guibg=NONE ctermbg=NONE
" hi NonText guibg=NONE ctermbg=NONE

" LightLine
let g:lightline = {
            \ 'colorscheme': 'palenight',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightlineFugitive',
            \   'filename': 'LightlineFilename',
            \   'filetype': 'MyFiletype',
            \   'fileformat': 'MyFileformat'
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
function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
    " === Denite setup ==="
    " Use The Silver Searcher
    call denite#custom#var('file/rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    " Setup ignore patterns in your .agignore file!
    " https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'default_opts',
                \ ['--vimgrep', '--smart-case' ])
    " Remove date from buffer list
    call denite#custom#var('buffer', 'date_format', '')

    " Custom options for Denite
    "   auto_resize             - Auto resize the Denite window height automatically.
    "   prompt                  - Customize denite prompt
    "   direction               - Specify Denite window direction as directly below current pane
    "   winminheight            - Specify min height for Denite window
    "   highlight_mode_insert   - Specify h1-CursorLine in insert mode
    "   prompt_highlight        - Specify color of prompt
    "   highlight_matched_char  - Matched characters highlight
    "   highlight_matched_range - matched range highlight
    let s:denite_options = {'default' : {
                \ 'auto_resize': 1,
                \ 'prompt': 'λ:',
                \ 'direction': 'rightbelow',
                \ 'winminheight': '10',
                \ 'highlight_mode_insert': 'Visual',
                \ 'highlight_mode_normal': 'Visual',
                \ 'prompt_highlight': 'Function',
                \ 'highlight_matched_char': 'Function',
                \ 'highlight_matched_range': 'Normal'
                \ }}

    " Loop through denite options and enable them
    function! s:profile(opts) abort
        for l:fname in keys(a:opts)
            for l:dopt in keys(a:opts[l:fname])
                call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
            endfor
        endfor
    endfunction

    call s:profile(s:denite_options)
catch
    echo 'Denite not installed. It should work after running :PlugInstall'
endtry

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

autocmd BufNewFile,BufRead *.tern-project set filetype=json
"autocmd BufNewFile,BufRead *.js set filetype=javascript.jsx
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
autocmd Filetype pug setlocal ts=2 sts=2 sw=2

" NERDtree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 25
let g:NERDTreeCascadeOpenSingleChildDir = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 0
let g:NERDTreeAutoDeleteBuffer = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeBookmarksFile = $VARPATH.'/treemarks'
let g:NERDTreeStatusline = '%#NonText#'
let NERDTreeIgnore = [
            \     '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.svn$',
            \     '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.cache$'
            \ ]
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
autocmd WinEnter * if exists('t:NERDTreeBufName') &&
            \ bufwinnr(t:NERDTreeBufName) != -1 && winnr("$") == 1 | q | endif

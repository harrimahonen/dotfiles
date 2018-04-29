"
" WebVim Configuration : Plugins configuration
"
" author: Bertrand Chevrier <chevrier.bertrand@gmail.com>
" source: https://github.com/krampstudio/dotvim
" year  : 2015
"

" TODO split by plugin ?


" [> NERDTree <]

" on vim enter opens nerd tree
function! OpenNerdTree()
    let s:exclude = ['COMMIT_EDITMSG', 'MERGE_MSG']
    if index(s:exclude, expand('%:t')) < 0
        NERDTreeFind
        exec "normal! \<c-w>\<c-w>"
    endif
endfunction
"autocmd VimEnter * call OpenNerdTree()

" nerdtree autoclose if it is the last opened buffer
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" nerdtree window resize
let g:NERDTreeWinSize = 35

" show hidden files
let g:NERDTreeShowHidden=1

" single click to open nodes
" let g:NERDTreeMouseMode=3

" ignored files
let g:NERDTreeIgnore=['\.swp$', '\~$', '\.pyc$']
nnoremap <c-n> :NERDTreeToggle<cr>

" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

" Enable completion where available.
let g:ale_completion_enabled = 1
nnoremap <c-f> <esc>:ALEFix<cr>


" [> NERDCommenter <]

noremap <c-_> :call NERDComment(0, "Toggle")<cr>

" Multiple Cursors
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-y>'
let g:multi_cursor_select_all_word_key = '<A-k>'
let g:multi_cursor_start_key           = 'g<C-k>'
let g:multi_cursor_select_all_key      = 'g<A-k>'
let g:multi_cursor_next_key            = '<C-k>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" [> Airline <]

" status line always opened
set laststatus=2

let g:airline#extensions#tabline#enabled = 1

"  powerline font
let g:airline_powerline_fonts = 1

" show the buffer numbers
let g:airline#extensions#tabline#buffer_nr_show = 1

" MatchTagsAlways filetypes
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'js' : 1,
    \ 'jsx' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}


" [> EditorConfig <]

" to avoid issues with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" [> PyMode <]
let g:pymode_lint = 0  " Handled by syntastic
"let g:pymode_lint_ignore = "E501"
let g:pymode_folding = 0
let g:pymode_syntax_slow_sync = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_options = 0


" [> YankStack <]

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste


" [> Javascript libraries syntax <]

let g:used_javascript_libs = 'jquery,underscore,requirejs,chai,handlebars'


" [> CtrlP <]
" lazy update
let g:ctrlp_lazy_update = 1

" Ignore files and folders
if executable('ag')
    " Use ag over anything else
    let g:ctrlp_user_command = 'ag %s -l --nocolor --path-to-agignore ~/.agignore -g ""'
else
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc     " MacOSX/Linux
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules)$',
    \ 'file': '\v\.(exe|so|dll|pdf|toc|log|out|aux)$',
    \ }
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -v  "flash\|3rd_party\|flex\|objectivec\|java\|system_tests\|csharp"']
endif

" Theme
colorscheme PaperColor
highlight ColorColumn ctermbg=8
set colorcolumn=100


" [> JS Context Color <]
" Disabled by default. Call JSContextColor to enable
let g:js_context_colors_enabled = 0


" [> Ultisnips <]
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" [> Tern <]
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
nnoremap <c-c>rr :TernRename<Cr>

" [> TagBar <]
nnoremap <a-n> :TagbarToggle<cr>

" [> Sessions <]
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" [> Tmuxline <]
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_preset = 'tmux'

" [> ESearch <]
if executable('ag')
    " Use ag over anything else
    let g:esearch = {
    \ 'adapter':    'ag',
    \ 'use':        ['visual', 'hlsearch', 'last'],
    \}
endif

" [> vim-test <]
let test#strategy = "neoterm"
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

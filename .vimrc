if &compatible
    set nocompatible
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
"NeoBundle 'gerw/vim-latex-suite'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'mhinz/vim-startify'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'sonph/onehalf'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'whatyouhide/vim-gotham'
NeoBundle 'rakr/vim-one'
NeoBundle 'kristijanhusak/vim-hybrid-material'

NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Lokaltog/powerline'
NeoBundle 'Shougo/neocomplete.vim.git'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'powerline/fonts'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'luochen1990/rainbow'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'JamshedVesuna/vim-markdown-preview'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck

let mapleader=','
filetype on
syntax enable
syntax on
map <silent><F5> :w<Enter>
map <silent><F6> :q!<Enter>
map <silent><leader>hl :noh<Enter>
map <F3> :TagbarToggle<CR>
let g:tagbar_width=25
set incsearch
set hlsearch
set guifont=Source\ Code\ Pro\ for\ Powerline:h14
set nu
set wildmenu
set wildmode=longest,list,full
set expandtab
set virtualedit=onemore
set so=5
set nowrap
set sidescroll=1

"statuesline
set laststatus=2
"set statusline+=%{fugitive#statusline()}

set backspace=indent,eol,start
set ignorecase
set autoindent
set shiftwidth=4
set tabstop=4
set background=dark
scriptencoding utf-8


"theme
set t_Co=256
let g:airline_theme = "one"
"let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
map <C-n> :bn<CR>
colorscheme gruvbox

"NeoComplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 15
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
set conceallevel=2 concealcursor=niv
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
noremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

function! CleverCr()
    if pumvisible()
        if neosnippet#expandable()
            let exp = "\<Plug>(neosnippet_expand)"
            return exp . neocomplete#smart_close_popup()
        else
            return neocomplete#smart_close_popup()
        endif
    else
        return "\<CR>"
    endif
endfunction
imap <expr> <CR> CleverCr()
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#smart_close_popup()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
function! CleverTab()
    if pumvisible()
        return "\<C-n>"
    endif
    let substr = strpart(getline('.'), 0, col('.') - 1)
    let substr = matchstr(substr, '[^ \t]*$')
    if strlen(substr) == 0
        return "\<Tab>"
    else
        if neosnippet#expandable_or_jumpable()
            return "\<Plug>(neosnippet_expand_or_jump)"
        else
            return neocomplete#start_manual_complete()
        endif
    endif
endfunction
imap <expr> <Tab> CleverTab()
"autocmd FileType python setlocal :mnifunc=pythoncomplete#Complete

"NerdTree
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"java-complete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

"syntastic
let g:syntastic_python_checkers=['flake8']
"let g:syntastic_java_javac_options = '-d bin'
"let g:JavaComplete_JavaCompiler="/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home/bin/javac"
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_java_javac_delete_output = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = get(g:, 'spacevim_error_symbol', '✖')
let g:syntastic_warning_symbol = get(g:, 'spacevim_warning_symbol', '➤')
let g:syntastic_vimlint_options = {
            \'EVL102': 1 ,
            \'EVL103': 1 ,
            \'EVL205': 1 ,
            \'EVL105': 1 ,
            \}
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

"rainbow
let g:rainbow_active = 1

"YouCompleteMe
"let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
"let g:acp_enableAtStartup = 0
"let g:UltiSnipsExpandTrigger = '<C-j>'
"let g:UltiSnipsJumpForwardTrigger = '<C-j>'
"let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"set completeopt-=preview

"Indent
set ts=4 sw=4 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

"clang_complete
let g:clang_library_path='/usr/local/Cellar/llvm/3.9.1/lib'
autocmd FileType c,cpp set omnifunc=ClangComplete
autocmd FileType c,cpp set completefunc=ClangComplete

"load words of startify
let g:startify_custom_header=[
            \ '',
            \ '',
            \ '    /#########                 /##         /##     /##                          /##      /##   /####',
            \ '   /##_______/                 |##         \ ##   /##                          | ##      \_/  |##_/',
            \ '  | ##         /#######   /#######  /#######\ ## /##/#######  /##   /## /## /##| ##      /##/#######/#######',
            \ '  | ##        /##____ ## /##___ ## /##____ ##\ ####/##____ ##| ##  | ##| ##/## | ##     | ##\_ ##_//##____ ##',
            \ '  | ##        |##   | ##| ##  | ##| ########  \ ## |##   | ##| ##  | ##| ###   | ##     | ## | ## | ########',
            \ '  | ##        |##   | ##| ##  | ##| ##_____/  | ## |##   | ##| ##  | ##| ##    | ##     | ## | ## | ##_____/',
            \ '  |  #########| #######  \ ####### \ #######  | ## | #######  \ ###### | ##    | #######| ## | ##  \ #######',
            \ '   \_________/ \______/   \______/  \_____/    \_/  \______/   \_____/  \_/     \______/ \_/  \_/   \_____/',
            \]

"一键运行
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr><C-o>
function! RunPython() abort
    :!chmod +x %
    :!time ./%
endfunction
function! RunJava() abort
    :!javac %
    :!time java %<
endfunction
autocmd FileType java nnoremap <expr><leader>rf RunJava()
autocmd FileType python nnoremap <expr><leader>rf RunPython()

"latex
set grepprg=grep\ -nH\ $*
set iskeyword+=:
autocmd BufEnter *.tex set sw=2
let g:tex_flavor = "latex"
autocmd FileType tex set conceallevel=0

"markdown
let vim_markdown_preview_toggle=1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_temp_file=1
let vim_markdown_preview_github=1
"autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"autocmd FileType markdown nnoremap <leader>rf :Instantmd<Enter>

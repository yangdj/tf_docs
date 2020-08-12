set nocompatible
filetype off
packadd! matchit

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/webapi-vim'
Plugin 'vim-scripts/ZoomWin'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/winmanager'
Plugin 'SirVer/ultisnips'
Plugin 'tweekmonster/django-plus.vim'
Plugin 'vim-scripts/dbext.vim'

if $MY_SHELL == 'zsh' || $MY_HADOOP_HOME != ''
    Plugin 'Valloric/YouCompleteMe'
endif 

call vundle#end()
filetype plugin on

let mapleader = ','

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let NERDTreeWinSize = 26

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" emmet

" To remap the default <C-Y> leader
let g:user_emmet_leader_key=',e'

" Enable just for html/css
" let g:user_emmet_install_global = 0

" enable close tag
let g:emmet_html5=1
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.MY_SOFTWARE/config/vim/.snippets_custom.json')), "\n"))

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ycm

let g:ycm_global_ycm_extra_conf = "~/.MY_SOFTWARE/config/vim/.ycm_extra_conf.py"
let g:ycm_python_binary_path = "python3"
set completeopt=longest,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_semantic_triggers = {'python': ['re!from\s+\S+\s+import\s']}
let g:ycm_goto_buffer_command = 'new-tab'
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ultisnips

let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><c-b>"
let g:UltiSnipsJumpBackwardTrigger="<leader><c-z>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bufexplorer
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 26  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
let g:bufExplorerShowDirectories=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" winmanager
let g:winManagerWindowLayout = "NERDTree|BufExplorer"
let g:winManagerWidth = 26
let g:defaultExplorer = 0

let g:NERDTree_title="[NERDTree]"

nnoremap <leader>m :WMToggle<cr>:q<cr> " :q<cr> to close the blank window
nnoremap <leader>cm :WMToggle<cr>

function! NERDTree_Start()
    exec 'NERDTree'
    endfunction

function! NERDTree_IsValid()
    return 1
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" zoomwin

nmap <leader>z <plug>ZoomWin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dbext

autocmd VimEnter *.sql DBCompleteTables
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" basic setting

augroup file
    autocmd FileType html,css,md EmmetInstall
    autocmd FileType * setlocal foldmethod=marker
augroup END

syntax on
set shortmess=I
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
set number
set background=dark
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4
set laststatus=2
set statusline=%f\ FileType=%y%=current:\ %-4l\ %-4c\ total:\ %4L
" set textwidth=79 " for existing line, select the line, use gqq to wrap the line
" set colorcolumn=+1
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
set backspace=2
" 0 same as “:set backspace=” (Vi compatible)
" 1 same as “:set backspace=indent,eol”
" 2 same as “:set backspace=indent,eol,start”

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key mapping

inoremap jk <esc>
inoremap <leader>, <bs><bs><bs><bs>
inoremap <leader>{ <space>{<cr>}<esc>ko<tab>
inoremap <leader>} {<cr>}<esc>ko<tab>
inoremap <leader>( <space>(<cr>)<esc>ko<tab>
inoremap <leader>) (<cr>)<esc>ko<tab>

nnoremap <leader>n :NERDTree<cr>
nnoremap <leader>q :quit<cr>
nnoremap <leader>t :tabedit<cr>
nnoremap <leader>w :set wrap!<cr>
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>eb :tabedit ~/.${MY_SHELL}rc<cr>
nnoremap <leader>sb :!source ~/.${MY_SHELL}rc<cr>
nnoremap <leader>et :tabedit ~/.tmux.conf<cr>
nnoremap <leader>sx :!source ~/.tmux.conf<cr>
nnoremap <leader>fh :set filetype=help<cr>
nnoremap <leader>ft :set filetype=text<cr>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" <c-a> has been used by tmux
nnoremap <leader>a <c-a>

if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L
    au GUIEnter * simalt ~x
    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        set guifont=Consolas:h14
        color industry
        cd F:\tfft\work_for\xz
    endif
endif

if filereadable($MY_CONFIG_HOME."/vim/.dbconfig.vim")
    source $MY_CONFIG_HOME/vim/.dbconfig.vim
endif

" if filereadable(expand("~/.dbconfig.vim"))
    " source ~/.dbconfig.vim
" endif

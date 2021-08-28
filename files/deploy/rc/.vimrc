let mapleader = ','
syntax on

set shortmess=I
set number
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set laststatus=2
set statusline=%f\ FileType=%y%=current:\ %-4l\ %-4c\ total:\ %4L
set backspace=2
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936

" key mapping
inoremap jk <esc>
nnoremap <leader>q :quit<cr>
nnoremap <leader>t :tabedit<cr>
nnoremap <leader>w :set wrap!<cr>
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" <c-a> has been used by tmux
nnoremap <leader>a <c-a>

if has("gui_running")
    set background=dark
    highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
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
    endif
endif

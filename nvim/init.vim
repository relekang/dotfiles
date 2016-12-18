if &compatible
  set nocompatible
endif

set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('ryyppy/deoplete-flow')
call dein#add('pangloss/vim-javascript')
call dein#add('neomake/neomake')
call dein#add('vim-airline/vim-airline')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('jistr/vim-nerdtree-tabs')

call dein#add('scwood/vim-hybrid')

call dein#end()


" Theme
syntax enable
colorscheme hybrid
set background=dark


set cc=100
set number
set tabstop=2
set shiftwidth=2
set laststatus=2 " always show the status line
set backspace=indent,eol,start
set autoread  "Autoreload edited files
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1


autocmd BufWritePre * :%s/\s\+$//e

map + <plug>NERDTreeTabsToggle<CR>

" ctrlp
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Tab sizing
au FileType python setl sw=4 sts=4 et
au FileType coffee setl sw=2 sts=2 et
au Filetype javascript set sw=2 sts=2 et

" Keymaps
nmap <Leader><Space>, :ll<CR>

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint', 'flow']
let g:neomake_json_enabled_makers = ['jsonlint']
let g:neomake_python_enabled_makers = ['flake8']

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#flow#flow_bin = 'flow'

" Javascript
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

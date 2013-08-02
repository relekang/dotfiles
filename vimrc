call pathogen#infect()

set t_Co=256
set cc=100

" Linje nummerering
set number

"Load bashrc to !
set shellcmdflag=-ic
 
"Setter på automatisk innrykk og halverer innrykk lengden
set autoindent
set tabstop=4 shiftwidth=2 expandtab

let g:solarized_termcolors=256

"Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_javascript_jslint_conf=""

"NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.vim$', '\~$', '.*\.egg-info', '.*\.pyc$', '.*\project.db$']

syntax enable
set background=dark
colorscheme solarized

autocmd vimenter *.py NERDTree
autocmd vimenter *.html NERDTree
autocmd vimenter *.pp set filetype=puppet
autocmd vimenter *.rb set tabstop=2
autocmd vimenter *.less set tabstop=2
au BufRead,BufNewFile *.pp              set filetype=puppet



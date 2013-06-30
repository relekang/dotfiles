call pathogen#infect()

set t_Co=256

" Linje nummerering
set number
 
"Setter på automatisk innrykk og halverer innrykk lengden
set autoindent
set tabstop=4 shiftwidth=2 expandtab

let g:solarized_termcolors=256

syntax enable
set background=dark
colorscheme solarized

autocmd vimenter *.py NERDTree
autocmd vimenter *.html NERDTree
autocmd vimenter *.pp set filetype=puppet
au BufRead,BufNewFile *.pp              set filetype=puppet

let NERDTreeIgnore=['\.vim$', '\~$', '.*\.egg-info', '.*\.pyc$', '.*\project.db$']

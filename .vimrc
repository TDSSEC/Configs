set number
set showmatch
"------------------"
"Colours"
syntax enable

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE guifg=DarkGrey guibg=NONE
set background=dark
"-------------------"

"-------------------"
"Tab indents"
set tabstop=4
set shiftwidth=4
set ai "auto indent"
set si "smart indent"
set wrap "wrap lines"
"-------------------"

set laststatus=2
execute pathogen#infect()
syntax on
filetype plugin indent on

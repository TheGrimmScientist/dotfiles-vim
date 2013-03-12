" Make Vim behave in a more useful way
set nocompatible

" Pathogen
call pathogen#runtime_append_all_bundles() 

" Color theme
syntax on
let g:molokai_original = 1
set t_Co=256
colorscheme molokai

" Highlight word under cursor
autocmd CursorMoved * exe printf('match StatusLine /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Spell check
setlocal spell spelllang=en_us

" Get all sorts of fontacular across multiple platforms...
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 10
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
    set lines=56 columns=220
  endif
endif

" Powerline awesomeness, if a patched font is available
set guifont=Consolas\ for\ Powerline\ FixedD:h9
set encoding=utf-8
let g:Powerline_symbols="fancy"

" General stuff
set number
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set showmatch
set mouse=a
set autoindent
set cursorline
set formatoptions+=r
set backspace=indent,eol,start

" I forgot why this is necessary...but it is, promise!
filetype off
filetype on

" Status Line Left Side
set laststatus=2
set statusline+=[%n]
set statusline+=\ %<%.99f
set statusline+=\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y
"" Status Line Right Side
set statusline+=%=
set statusline+=ASCII\:\ %03.b
set statusline+=\ %-16(\ %l,%c-%v\ %)%P

" Hex editing goodness
command Hex :%!xxd
command Unhex :%!xxd -r

" Get multiple undo working
set cpoptions-=u

" Make screen/byobu happy
if &term == "screen-bce"
  set ttymouse=xterm2
  imap <Up> <ESC>kj
  imap <Down> <ESC>ki
  imap <Right> <ESC>kl
  imap <Left> <ESC>kh
endif

" Code folding goodies
set fdc=2
set fdm=syntax
nnoremap <space> za
vnoremap <space> zf
set foldlevelstart=1
set foldnestmax=2
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" File Formats
autocmd BufNewFile,BufRead *.json set ft=javascript
" TODO: Get fancy with PEP8 for Python
" Use flake8? https://github.com/nvie/vim-flake8
" Or python-mode? https://github.com/klen/python-mode

" listchars setup with toggle
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=#4a4a59 ctermfg=236 ctermbg=NONE
highlight SpecialKey guifg=#4a4a59 ctermfg=236 ctermbg=NONE

" Super nifty mappings
" ------------------------------------------------------------------------------

" ragtag
let g:ragtag_global_maps=1
" Find word under cursor in files, recursing from current directory down
map <leader>f :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
" Open file under cursor in new tab
map gf :tabnew <cfile><CR>
" Make <c-u> play nice with undo
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
" Write files with sudo permissions
cmap w!! %!sudo tee > /dev/null %
" Tagbar goodness
nmap <leader>t :TagbarToggle<CR>
" NERD Tree Toggle
nmap <silent> <c-n> :NERDTreeToggle<CR>
" Ctrl + R search & replace of selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Toggle paste mode to play nice with PuTTY
set pastetoggle=<leader>p

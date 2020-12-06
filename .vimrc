set encoding=utf-8

let mapleader = " "

set ruler	" show cursor
set showcmd	" display incomplete commands
set incsearch
set hlsearch " Highlight search results
set ignorecase " Ignore case when searching
set number	" show line numbers
set showmatch " Show matching brackets when text indicator is over them

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" tabs are 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

augroup vimrcEx
  autocmd!

  " Jump to last known cursor position.
  " (not for commit messages, invalid positions, or inside event handler (?))
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-[> <Esc>
endif

" Set to auto read when a file is changed from the outside
set autoread

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remap VIM 0 to first non-blank character
map 0 ^

" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline

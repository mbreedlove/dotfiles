if &compatible
  set nocompatible               " Be iMproved
endif
""" Basics
syntax enable       " syntax highlighting on
if &compatible
  set nocompatible     " explicitly get out of vi-compatible mode
endif
set noexrc       " don't use local version of .(g)vimrc, .exrc
set background=dark     " we plan to use a dark background
filetype plugin indent on  " load filetype plugins/indent settings
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

""" Dein
if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  call dein#add('Shougo/dein.vim')

  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })

  "" Language
  " " Ruby
  call dein#add('vim-ruby/vim-ruby', { 'on_ft': 'ruby' })
  call dein#add('tpope/vim-rails', { 'on_ft': 'ruby' })
  call dein#add('tpope/vim-bundler', { 'on_ft': 'ruby' })
  " " Elixir
  call dein#add('elixir-editors/vim-elixir', { 'on_ft': 'elixir' })
  call dein#add('slashmili/alchemist.vim', { 'on_ft': 'elixir' })
  " " Javascript
  "call dein#add('leafgarland/typescript-vim', { 'on_ft': 'typescript' })
  call dein#add('HerringtonDarkholme/yats.vim', { 'on_ft': 'typescript' })
  call dein#add('Quramy/tsuquyomi', { 'on_ft': 'typescript' })
  call dein#add('glanotte/vim-jasmine', { 'on_ft': 'jasmine' })
  call dein#add('elzr/vim-json', { 'on_ft': 'json' })
  call dein#add('MaxMEllon/vim-jsx-pretty', { 'on_ft': 'javascript.jsx' })
  call dein#add('briancollins/vim-jst')

  call dein#add('mattn/emmet-vim', { 'on_ft': 'html' })
  "call dein#add('vim-syntastic/syntastic')
  call dein#add('w0rp/ale')
  call dein#add('scrooloose/nerdcommenter')
  "call dein#add('julialang/julia-vim', { 'on_ft': 'julia' })

  " Completion
  call dein#add('tpope/vim-endwise', { 'on_i': 1 })
  "call dein#add('townk/vim-autoclose', { 'on_i': 1 })
  call dein#add('Raimondi/delimitMate', { 'on_i': 1 })
  call dein#add('Valloric/YouCompleteMe', { 'build': './install.py --all' })

  " Code Display
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('altercation/vim-colors-solarized')
  set runtimepath+=~/.vim/dein/repos/github.com/altercation/vim-colors-solarized

  " Integrations
  call dein#add('mileszs/ack.vim', { 'on_cmd': 'Ack' })
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NerdTreeToggle' })
  call dein#add('Xuyuanp/nerdtree-git-plugin', { 'on_cmd': 'NerdTreeToggle' })
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('prettier/vim-prettier')

  " Interface
  call dein#add('junegunn/fzf', { 'build': './install --all' })
  call dein#add('junegunn/fzf.vim', { 'on_cmd': 'Files' })
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Commands
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('easymotion/vim-easymotion')

  " Other
  call dein#add('tpope/vim-sensible')
  call dein#add('tpope/vim-sleuth')
  call dein#add('vim-scripts/HTML-AutoCloseTag', { 'on_ft': 'html' })
  call dein#add('editorconfig/editorconfig-vim')

  if has('nvim')
    " Neovim specific stuff
  endif

  call dein#end()
  call dein#save_state()

  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif
endif

" General {
set omnifunc=syntaxcomplete#Complete
set backspace=indent,eol,start    " make backspace a more flexible
set backup                        " make backup files
set backupdir=~/.vim/backup  " where to put backup files
set clipboard+=unnamed     " share windows clipboard
set directory=~/.vim/tmp   " directory to place swap files in
set fileformats=unix,dos,mac   " support all three, in this order
set hidden       " you can change buffers without saving
if has('mouse')
  set mouse=a       " use mouse everywhere
endif
set noerrorbells     " don't make noise

""" Vim UI
let g:solarized_termcolors=16
colorscheme solarized
set linespace=0              " don't insert any extra pixel lines betweens rows
"set list                     " we do what to show tabs, to ensure we get them out of my files
"set listchars=tab:>-,trail:- " show tabs and trailing
set matchtime=5              " how many tenths of a second to blink matching brackets for
set nohlsearch               " do not highlight searched for phrases
set incsearch                " DO highlight first term as you type
set nostartofline            " leave my cursor where it was
set visualbell t_vb=
set number                   " turn on line numbers
set numberwidth=4            " We are good up to 9999 lines
set report=0                 " tell us when anything is changed via :...
set ruler                    " Always show current positions along the bottom
set scrolloff=5              " Keep 10 lines (top/bottom) for scope
set shortmess=aOstT          " shortens messages to avoid 'press a key' prompt
set showcmd                  " show the command being typed
set showmatch                " show matching brackets
set sidescrolloff=10         " Keep 5 lines at the size


""" Text Formatting/Layout
set completeopt=     " don't use a pop up menu for completions
set expandtab       " no real tabs please!
set formatoptions=rq     " Automatically insert comment leader on return, and let gq format comments
set ignorecase       " case insensitive by default
set infercase       " case inferred by default
set nowrap       " do not wrap line
set shiftround       " when at 3 spaces, and I hit > ... go to 4, not 5
set smartcase       " if there are caps, go case-sensitive
set smartindent     " set smartindent
set shiftwidth=2     " auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=2     " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=4 " real tabs should be 8, and they will show with set list on

""" Mappings
" Buffers
nmap <leader>T  :enew<CR>   " Open new buffer
nmap <leader>l  :bnext<CR>  " Next buffer
nmap <leader>h  :bprev<CR>  " Previous buffer
" Emulate 'closing' the tab
nmap <leader>q :bprev <BAR> bdelete #<CR>

" CtrlP opens FZF
nmap <C-p> :Files<CR>

set pastetoggle=<F2>                        " <F2> toggles paste mode
set t_BE=            " Don't show annoying <PasteStart> and <PasteEnd> tags

""" NerdTREE
" Open NerdTREE if no files specified
"   autocmd StdinReadPre * let s:std_in=1
"   autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NerdTREE key binding
map <C-f> :NERDTreeToggle<CR>
" Close Vim if only window is NerdTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag for Ack
  let g:ackprg = 'ag --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

""" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

""" GitGutter
" Don't set keymappings, use Fugitive for Git management
let g:gitgutter_map_keys = 0

""" Multiple Cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Allows exiting back to normal mode rather than exiting multi_cursor
let g:multi_cursor_exit_from_insert_mode=0

""" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,htmldjango,scss,eruby,less,eelixir EmmetInstall
let g:user_emmet_expandabbr_key = '<Tab>' " Tab expands tags
let g:user_emmet_mode='i'    "enable all function in all mode.

" Vim-Jasmine
autocmd BufReadPost,BufNewFile *.spec.ts set filetype=jasmine.javascript syntax=jasmine

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_typescript_checkers = ['tsuquyomi'] 

let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_single_quote_import=1

" disable contextual completion
"set complete=
let g:ycm_autoclose_preview_window_after_completion=1
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers =  {
	\   'c' : ['->', '.'],
	\   'objc' : ['->', '.'],
	\   'ocaml' : ['.', '#'],
	\   'cpp,objcpp' : ['->', '.', '::'],
	\   'perl' : ['->'],
	\   'php' : ['->', '::', '"', "'", 'use ', 'namespace ', '\'],
	\   'cs,jasmine,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
	\   'html': ['<', '"', '</', ' '],
	\   'vim' : ['re![_a-za-z]+[_\w]*\.'],
	\   'ruby' : ['.', '::'],
	\   'lua' : ['.', ':'],
	\   'erlang' : [':'],
	\   'haskell' : ['.', 're!.']
	\ }
endif
let g:NERDTreeWinSize = 40 
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

""" Prettier
""" Change back to default prettier settings
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'

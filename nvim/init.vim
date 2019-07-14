source ~/.config/nvim/plugins.vim

if &compatible
  set nocompatible               " Be iMproved
endif

""" Basics
syntax enable           " syntax highlighting on
set number              " Show line numbers

""" General
set backspace=indent,eol,start    " make backspace a more flexible
set nobackup                        " do not make backup files
set nowritebackup
set fileformats=unix,dos,mac   " support all three, in this order
set hidden       " you can change buffers without saving
if has('mouse')
  set mouse=a       " use mouse everywhere
endif
set noerrorbells     " don't make noise

""" UI
let g:solarized_termcolors=16
set background=dark     " dark background
try
  colorscheme solarized
catch
  colorscheme slate
endtry

""" Vim UI
set linespace=0              " don't insert any extra pixel lines betweens rows
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
set ignorecase          " case insensitive by default
set infercase           " case inferred by default
set nowrap              " do not wrap line
set shiftround          " when at 3 spaces, and I hit > ... go to 4, not 5
set smartcase           " if there are caps, go case-sensitive
set smartindent         " set smartindent
set shiftwidth=2        " auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=2       " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=4           " real tabs should be 8, and they will show with set list on
set clipboard=unnamed   " Yank and paste with system clipboard
set pastetoggle=<F2>    " <F2> toggles paste mode
set t_BE=               " Don't show annoying <PasteStart> and <PasteEnd> tags


" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "
"" Buffers
nmap <leader>T  :enew<CR>   " Open new buffer
nmap <leader>l  :bnext<CR>  " Next buffer
nmap <leader>h  :bprev<CR>  " Previous buffer
"" Emulate 'closing' the tab
nmap <leader>q :bprev <BAR> bdelete #<CR>

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer -split=floating -winrow=1<CR>
"nmap <leader>t :Denite file/rec -split=floating -winrow=1<CR>
nmap <C-p> :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty -mode=normal<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" Close Vim if only window is NerdTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Use arrows to navigate candidates
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'prompt': 'λ:',
\ 'direction': 'rightbelow',
\ 'winminheight': '10',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === NERDTree === "
let g:NERDTreeWinSize = 40 

" === Fugitive === "
" Don't set keymappings, use Fugitive for Git management
let g:gitgutter_map_keys = 0

" === Vim Multiple Cursors === "
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Allows exiting back to normal mode rather than exiting multi_cursor
let g:multi_cursor_exit_from_insert_mode=0

" === Airline === "
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

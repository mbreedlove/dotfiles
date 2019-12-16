""" Dein
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
  call dein#add('Shougo/echodoc.vim')
  " For Denite features
  call dein#add('Shougo/denite.nvim')
  " For Completion
  call dein#add('neoclide/coc.nvim', {'merge':0, 'build': './install.sh nightly'})

  "" Language
  """ Typescript
  call dein#add('HerringtonDarkholme/yats.vim') ", { 'on_ft': 'typescript' })
  call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})

  call dein#add('scrooloose/nerdcommenter')

  " Completion
  call dein#add('tpope/vim-endwise', { 'on_i': 1 })
  call dein#add('Raimondi/delimitMate', { 'on_i': 1 })

  " Code Display
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('altercation/vim-colors-solarized')
  set runtimepath+=~/.cache/dein/repos/github.com/altercation/vim-colors-solarized

  " Integrations
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NerdTreeToggle' })
  call dein#add('Xuyuanp/nerdtree-git-plugin', { 'on_cmd': 'NerdTreeToggle' })
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " Interface
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

  call dein#end()
  call dein#save_state()

  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif
endif

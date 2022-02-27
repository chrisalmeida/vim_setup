#!/usr/bin/env bash

VIMRC="set relativenumber\nset number\nset cursorline\nset laststatus=2\nset colorcolumn=80\nexecute pathogen#infect()\nsyntax on\ncolorscheme PaperColor\nmap <C-n> :NERDTreeToggle<CR>\nset t_Co=256\nset background=dark\nhi Normal ctermbg=none\nlet g:airline#extensions#tabline#enabled = 1\nlet g:prettier#autoformat = 1\nlet g:prettier#autoformat_require_pragma = 0\nlet g:prettier#config#use_tabs = 'false'\nlet g:prettier#config#tab_width = 2"

Plugs="https://github.com/NLKNguyen/papercolor-theme.git https://github.com/airblade/vim-gitgutter.git https://github.com/ElmCast/elm-vim.git https://github.com/scrooloose/nerdtree.git https://github.com/Yggdroot/indentLine.git https://github.com/vim-airline/vim-airline.git https://github.com/elixir-lang/vim-elixir.git https://github.com/prettier/vim-prettier"

CONFIG_DIRECTORY=~/.config/nvim
BUNDLE="$CONFIG_DIRECTORY/bundle"

installPathogen () {
  echo "Installing in $BUNDLE"
  if [ ! -d  "$BUNDLE" ]; then
    mkdir -p "$CONFIG_DIRECTORY/autoload" "$BUNDLE" && \
    curl -LSso "$CONFIG_DIRECTORY/autoload/pathogen.vim" https://tpo.pe/pathogen.vim
  fi
}

clonePlugins () {
  pwd
  for i in $Plugs
  do
    git clone $i
  done;
}

addThemeToVimColors () {
  cd "$BUNDLE/papercolor-theme/colors" && \
  mkdir "$CONFIG_DIRECTORY/colors" && \
  cp PaperColor.vim "$CONFIG_DIRECTORY/colors" \
  && echo "Color theme is now in $CONFIG_DIRECTORY/colors"
}

setVimRc () {
  echo -e $VIMRC >> "$CONFIG_DIRECTORY/init.vim"
}

if [ "test nvim" ] && [ "test git" ]; then 
  installPathogen && cd $BUNDLE && clonePlugins && addThemeToVimColors && setVimRc
else
  echo "Make sure GIT and VIM are installed on your machine."
fi


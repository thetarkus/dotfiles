" vim: set filetype=vim:
"""
""" Plugins
"""
if has('nvim')
  let vimpath = '~/.local/share/nvim'
  let plugpath = vimpath . '/site/autoload/plug.vim'
  let pluginspath = vimpath . '/plugged'
else
  let vimpath = '~/.vim'
  let plugpath = vimpath . '/autoload/plug.vim'
  let pluginspath = vimpath . '/plugged'
endif

" Plug Installer
if empty(glob(plugpath))
  exec 'silent !curl -fLo ' . plugpath . ' --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  augroup PLUG
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

" Plugins
call plug#begin(pluginspath)

" Vim 8
if !has('nvim')
  Plug 'tpope/vim-sensible'            " Sensible defaults
  Plug 'markonm/traces.vim'            " Live substitute for Vim 8
endif

" Completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                " Fuzzy file finder
Plug 'scrooloose/nerdtree'             " File browser

" Snippets
Plug 'SirVer/ultisnips'                " Snippets engine
Plug 'honza/vim-snippets'              " Snippets

" Navigation
Plug 'rhysd/clever-f.vim'              " Extend f, t, F, T
Plug 'justinmk/vim-sneak'              " Easy cursor jumping; s/S
Plug 'christoomey/vim-tmux-navigator'  " Tmux split navigation

" Text
Plug 'tpope/vim-commentary'            " Commenting; [visual]gc
Plug 'tpope/vim-surround'              " Text surroundings
Plug 'junegunn/vim-easy-align'         " Text alignment; [visual]ga
Plug 'tommcdo/vim-exchange'            " Swap selections of code
"Plug 'jiangmiao/auto-pairs'            " {}, ''

" Visual
Plug 'Yggdroot/indentLine'             " Space indentation
Plug 'machakann/vim-highlightedyank'   " Briefly highlight yanked text
Plug 'romainl/vim-cool'                " Unhighlight searches

" Themes
Plug 'chriskempson/base16-vim'         " Base16 theme architecture

" UI
Plug 'junegunn/goyo.vim'               " Distraction free writing

" Functionality
Plug 'tpope/vim-repeat'                " Repeat for supported plugins
Plug 'tpope/vim-fugitive'              " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-sleuth'                " Indentation detection
Plug 'tpope/vim-eunuch'                " Unix shell commands
Plug 'moll/vim-bbye'                   " Close buffer; :Bdelete

" Syntax
Plug 'sheerun/vim-polyglot'            " Defaults for languages

" Languages
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}  " PHP


call plug#end()


"""
""" Built-in Settings
"""
syntax on
colorscheme base16-default-dark
set encoding=UTF-8
set t_Co=256
set background=dark
set hidden
if has('termguicolors')
 set termguicolors
endif

" Persistent Undo
if has('persistent_undo')
  let &undodir = expand('$HOME/.vim/undo')
  call system('mkdir -p ' . &undodir)
  set undofile
endif

" Cursor
set scrolloff=2
set nocursorline
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

" List
set list
set listchars=tab:\ ,trail:\ ,precedes:^,extends:$,eol:¬

" Commands
set showcmd

" Conceal
set conceallevel=2

" Regex Engine
set regexpengine=1

" Timeouts
set timeoutlen=1000
set ttimeoutlen=0

" Rulers
set colorcolumn=81

" Wrapping
set nowrap

" Indentation
set shiftwidth=0
set tabstop=4
set noexpandtab
set smarttab

" Leader
let mapleader = ' '

" Live substitution
if has('nvim')
  set inccommand=nosplit
endif

" Line numbers
set number
set relativenumber

" Status
set showmode

" Splits
set splitbelow
set splitright

" Sessions
let g:sessions_dir = vimpath + '/sessions'

" Messages
set shortmess+=c

" Completion
set completeopt+=menuone,noinsert
set completeopt-=preview



"""
""" Built-in Mappings
"""
" New lines
nnoremap <CR> i<CR><Esc>

" Searching
set ignorecase
set smartcase

" Write current directory
nnoremap <Leader>L :!echo %:p:h > ~/.previous-dir<CR><CR>

" Terminal
tnoremap <Leader><Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-W><C-H>
tnoremap <C-j> <C-\><C-n><C-W><C-J>
tnoremap <C-k> <C-\><C-n><C-W><C-K>
tnoremap <C-l> <C-\><C-n><C-W><C-L>

" Cut and Paste
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

" Save
noremap <Space><Esc> :w<CR>

" Buffer navigation
noremap <Leader>q :Bdelete<CR>

" Tab navigation
noremap <Leader>h :tabprev<CR>
noremap <Leader>l :tabnext<CR>

" Line navigation
nnoremap <S-h> _
nnoremap <S-l> g_
vnoremap <S-h> _
vnoremap <S-l> g_

" Split navigation
map <Leader> <Nop>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Split resizing
nnoremap <C-w><C-y> :vertical resize -5<CR>
nnoremap <C-w><C-u> :resize -5<CR>
nnoremap <C-w><C-i> :resize +5<CR>
nnoremap <C-w><C-o> :vertical resize +5<CR>

" Visual
vnoremap // y/<C-R>"<CR>



"""
""" Plugin Settings
"""
" FZF
let rg_args = {'options': '--delimiter : --nth 4..'}
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading -g "!node_modules" --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview(rg_args, 'up:60%')
  \           : fzf#vim#with_preview(rg_args, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>s :Rg<CR>

" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Sneak
let g:sneak#label = 1

" Ultisnips
let g:UltiSnipsJumpForwardTrigger = "<c-f>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" Easy Align
xmap ga <Plug>(EasyAlign)

" Indents
let g:indentLine_char = ''
let g:indentLine_leadingSpaceChar = ' '
let g:indentLine_conceallevel  = &conceallevel
let g:indentLine_concealcursor = &concealcursor

" Highlightedyank
let g:highlightedyank_highlight_duration = 250

" Goyo
nmap <silent> <Leader>G :Goyo<CR>
let g:goyo_linenr = 1
function! s:goyo_enter()
  let g:goyo_wrap = &wrap
  let g:goyo_linebreak = &linebreak
  set wrap
  set linebreak
  nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
  nnoremap <silent> 0 g0
  nnoremap <silent> $ g$
endfunction
function! s:goyo_leave()
  if g:goyo_wrap == 0 | set nowrap | endif
  if g:goyo_linebreak == 0 | set linebreak | endif
  nnoremap <silent> j j
  nnoremap <silent> k k
  nnoremap <silent> 0 g0
  nnoremap <silent> $ g$
endfunction

" Auto pairs
let g:AutoPairsMapCR = 0

" Vim-vue
let g:vue_disable_pre_processors = 1


"""
""" Autocmd Groups
"""
" File Types
augroup FILETYPES
  autocmd FileType vim let b:autopairs_enabled = 0
augroup END

" Vim Events
augroup EVENTS
  autocmd FocusGained,VimResized * :redraw!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

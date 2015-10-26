" The root of all evil
let mapleader = ","

"================== Plugin Manager ============================================
" plugin Vundle:

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle:let @/ = "" should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" Show differences for recovered files
Plugin 'chrisbra/Recover.vim'

" Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
" Plug 'junegunn/fzf', { 'dir': '~/opt/fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'

Plugin 'file:///home/pk/opt/vim-plugins/bufkill'
" Plugin 'ton/vim-bufsurf'
Plugin 'file:///home/pk/proiecte/vim-plugins/bufsurf'

" syntax highlight for GitHub Flavored Markdown
Plugin 'jtratner/vim-flavored-markdown'
" Preview GitHub Flavored Markdown in browser. Updates in real-time
Plugin 'suan/vim-instant-markdown'
" Preview GitHub Flavored Markdown in browser. Uptades on shortcut press -> meh
" Plugin 'JamshedVesuna/vim-markdown-preview'


" Highlight all instances of word under cursor, when idle.
Plugin 'file:///home/pk/opt/vim-plugins/autohighlight'
Plugin 'ntpeters/vim-better-whitespace'

" Plugin 'yonchu/accelerated-smooth-scroll'
Plugin 'terryma/vim-smooth-scroll'


"Plugin 'Rip-Rip/clang_complete'
"Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'

" Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'bbchung/clighter'
" Plugin 'file:///home/pk/proiecte/vim-plugins/clighter'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"================ Scripts ======================================================

nnoremap <C-W>o :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    " set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

"================ Vim Settings ================================================

" --- Autostart ---
" if has("gui_running")
"   " GUI is running or is about to start.
"   " Maximize gvim window.
"    set lines=999 columns=999
" endif

" autostart NERDTree
" if has("gui_running")
"   " start NERDTree
"   au VimEnter * NERDTree
"   " switch focus out of NERTTree
"   au VimEnter * normal l
"   " au VimEnter * vs
" endif

" colorschem (slate > desert)
if has("gui_running")
  colorscheme mustang-bolov

  if hostname() == "cpl"
    set guifont=ubuntu\ Mono\ 11
  endif

endif

" display options
set guioptions-=m  "remove menubar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" switching buffers
set switchbuf=useopen

" line numbers
set number

" whitespaces
set list
set listchars=tab:»—,trail:·

" highlighted matching pairs
set matchpairs+=<:>

" vertical line
set colorcolumn=80 " or set cc

" highlight current line only in current buffer
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter,FocusGained * setlocal cursorline
  autocmd WinLeave,FocusLost * setlocal nocursorline
augroup END

" tabs and indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" indentation for C
set cinoptions=:0    " case labels
set cinoptions+=g0   " scope declarations (public: etc)
set cinoptions+=N-s   " inside namespaces

augroup BolovFileTypes
  autocmd!
  autocmd BufRead,BufNewFile *.cu,*.cl set filetype=cpp

  autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4
        \                          expandtab smartindent

  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" key settings
set timeoutlen=3000

" smart case search
set ignorecase
set smartcase

" autocomplete mode for cmd
" list all and complete longest commom
:set wildmode=list:longest

" persistent undo
set undofile
set undodir=~/.vim/undo

" disable swap files
set noswapfile

"=============== Plugins Settings ============================================

"" --- clang complete ---
"
"" Disable auto popup, use <Tab> to autocomplete
"let g:clang_complete_auto = 0
"
"let g:clang_auto_select=0
"let g:clang_complete_copen=0
"let g:clang_snippets=1
"let g:clang_snippets_engine='clang_complete'
"" let g:clang_conceal_snippets=1
"let g:clang_trailing_placeholder=1
"let g:clang_user_options = '-std=c++11'
"let g:clang_complete_macros=1
"let g:clang_complete_patterns=1
"
"" set conceallevel=2
"" set concealcursor="vin"
"
"
"" setting this to 1 has a bug: it will always behave as clang_auto_select
"" is 1 and will not select the snippet
"" let g:clang_make_default_keymappings = 0
"
"" unlet g:clang_jumpto_declaration_key
"" unlet g:clang_jumpto_declaration_in_preview_key
"" unlet g:clang_jumpto_back_key
"
"" Complete options (menu, menuone, longest, preview)
"set completeopt=menuone,longest
"
"" Limit popup menu height
"" set pumheight=20
"
"" --- SuperTab ---
"
"" SuperTab option for context aware completion
"" let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType='<c-x><c-u>'
"let g:SuperTabLongestEnhanced=1

" --- Instant Markdown ---
set shell=bash\ -i  "  TODO might not be needed
let g:instant_markdown_slow=1

" --- YCM ---
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" --- CtrlP ---

"let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'

" open multiple files in curret buffer and jump to the first
let g:ctrlp_open_multiple_files = '1jr'

" use vim cwd as path
let g:ctrlp_working_path_mode=0

" --- SmoothScrool --- "
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 1)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 1)<CR>

" -- FZF ---
let g:fzf_launcher='gnome-terminal --disable-factory -x bash -ic %s'


" --- bufkill ---
let g:BufKillCreateMappings=0

" -- better whitespace --
highlight ExtraWhitespace guibg=#440000

" " --- eclim ---
" let g:EclimJavaCompilerAutoDetect=0
" let g:EclimFileTypeValidate=0
" let g:EclimShowCurrentError=0
" let g:EclimLogLevel='off'
" let g:EclimSignLevel='off'

"============== Custom Keyboard Shortcuts ====================================

" Alt key workaround for termial
" map i <Esc>

" disable shortcuts that I often accidentally press
" enter visual mode
nmap Q <nop>

" --- Clighter ---
let g:clighter_libclang_file = '/home/pk/llvm/install/lib/libclang.so'

let g:clighter_compile_args = ["-x", "c++", "-std=c++14", "-DLinux", "-I", "."]

let g:ClighterOccurrences = 0

" --- clang format ---

" format selection
map <Leader>f :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>

" format {}
map <Leader>g va{<Leader>f

" formal all file
map <Leader>F ggVG<Leader>f

" --- CtrlP ---

let g:ctrlp_map = '<Leader>p'
nmap <Leader>P :CtrlPMixed<CR>

nmap <Leader>t :CtrlPBufTag<CR>
nmap <Leader>T :CtrlPTag<CR>
nmap <Leader>l :CtrlPLine %<CR>
nmap <Leader>L :CtrlPLine<CR>

" --- CScope ---

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" open in preview
nmap <C-\>S :pedit! +cs\ find\ s\ <C-R>=expand("<cword>")<CR> %<CR>
nmap <C-\>G :pedit! +cs\ find\ g\ <C-R>=expand("<cword>")<CR> %<CR>

nmap <F2> <C-\>S
nmap <F3> <C-\>G

" --- YCM ---
nmap <Leader>y :YcmCompleter GoToDeclaration<CR>
" nmap <Leader>Y :YcmCompleter GoToDefinition<CR>
nmap <Leader>Y :YcmForceCompileAndDiagnostics<CR>


" --- Autohighlight ---

nnoremap <Leader>H :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>


" --- No plugins


" save
nmap <Leader>s :w<CR>
nmap <Leader>S :wa<CR>
" write with sudo privilege
cmap w!! w !sudo tee > /dev/null %

nmap <Leader>Q :qa<CR>

" edit files
nmap <Leader>ev :drop $MYVIMRC<CR>
nmap <Leader>em :drop Makefile<CR>

nmap <Leader>rv :so $MYVIMRC<CR>
nmap <Leader>rr :w<CR>:so %<CR>

" navigate buffers
nmap <C-h> :BufSurfBack<CR>
nmap <C-l> :BufSurfForward<CR>
nmap <C-j> :BufSurfList<CR>

" build
nmap <Leader>b :wa<CR>:make<CR>
nmap <Leader><F5> :wa<CR>:make run<CR>
nmap <Leader>B :wa<CR>:make build_metadata<CR>:cs reset<CR>

nmap <Leader>c :botright copen<CR>
nmap <Leader>C :ccl<CR>

" Move line(s) up/down

nnoremap <A-k> :m .-2<CR>
nnoremap <A-j> :m .+1<CR>

vnoremap <A-k> :m '<-2<CR>gv
vnoremap <A-j> :m '>+1<CR>gv

" Duplicate line(s)

nmap <Leader>d :co+0<CR>
vmap <Leader>d :co '>+0<CR>gv

" toogle search highlight
noremap <Leader>h :set hlsearch!<CR>

" write with sudo privilege
cmap w!! w !sudo tee > /dev/null %

" autocomplete braces
inoremap {<CR> {<CR>}<Esc>O

" skip closing parenthesis
" inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")"
"       \ ? "\<Right>" : ")"
" imap <expr> >  strpart(getline('.'), col('.')-1, 1) == ">"
"       \ ? "\<Right>" : ">"

" autocomplete closing parenthesis
" inoremap <A-(> ()<Left>
" inoremap <A-{> {}<Left>

" indent current line

"smart indent when entering insert mode with i on empty lines
function! ISmartIndentEmptyLine()
    if len(getline('.')) == 0
        " return "\"_ddO"
         return "cc" " <Esc>cc
    else
        return "==gi" " <Esc>==gi
    endif
endfunction

" inoremap <expr> i IndentWithI()
" inoremap <expr> <C-Tab> ISmartIndentEmptyLine()

"============== Load individual vimrc ==========================================

" finds the '.vimrc' file upward from a:search_dir
" returns:
"   - the .vimrc file path or
"   - empty string if no file was found or the default .vimrc file was found
function! GetLocalVimrc(search_dir)
  let local_vimrc_file = findfile(".vimrc", a:search_dir . ";")

  if empty(local_vimrc_file) || local_vimrc_file == $MYVIMRC
    return ""
  endif

  return local_vimrc_file
endfunction

function! LoadLocalVimrc()
  let local_vimrc_file = GetLocalVimrc(".")
  if empty(local_vimrc_file)
    return
  endif

  exec "source " . local_vimrc_file
endfunction

augroup LocalVimrc
  autocmd!
  autocmd BufNewFile,BufRead * call LoadLocalVimrc()
augroup END

"=============== Playground ====================================================


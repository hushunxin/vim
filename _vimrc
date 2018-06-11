source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"解决中文乱码
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,cp936,gb2312,latin1
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"tab设置为4个空格
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"取消VIM的自动备份功能,撤消功能等(自动生成的~文件其实很不待见)
set noundofile
set nobackup
set noswapfile

"设置颜色模式
colorscheme desert	
"设置字体、字号 
set guifont=Consolas:h12:cANSI
"开启高亮光标行
set cursorline
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=black guifg=green
"开启高亮光标列
"set cursorcolumn
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"隐藏菜单栏、工具
set go=
"设置显示行号
set number
"设置显示相对行号
"set relativenumber
"设置打开时默认窗口大小
set lines=35 columns=140
"set nowrap
"vim窗口默认最大化
"autocmd GUIEnter * simalt ~x

"将工作目录加入path,这样find命令就可以打开工作目录中的所有文件
set path+=**


"键盘映射
inoremap jk <ESC>
vnoremap . :norm.<CR>
"对文本中指定内容进行快速的全局删改
vmap qq y:%s`<C-R>"``g<left><left>
"关闭高亮功能的快捷键
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

""""""""""""""""""""""
"Quickly Run
""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!python.exe %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc


""""""""""""""""""""""
"vundle 插件 plugins
""""""""""""""""""""""
filetype off
"此处规定Vundle的路径
set rtp+=$VIM/vimfiles/bundle/vundle/
"此处规定插件的安装路径
call vundle#rc('$VIM/vimfiles/bundle/')
Bundle 'gmarik/vundle'
"Bundle 'L9'
"Bundle 'FuzzyFinder'
"Bundle 'https://github.com/rking/ag.vim'
"Bundle 'ctrlp.vim'
"Bundle 'https://github.com/junegunn/fzf'
"Bundle 'https://github.com/Yggdroot/LeaderF'
"Bundle 'vim-airline'
Bundle 'The-NERD-tree'
    " NERDTree config
    map <F2> :NERDTreeToggle<CR>
    "NERDTree窗口可以作为最后一个窗口
    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")&&b:NERDTreeType == "primary") | q | endif
"Bundle 'davidhalter/jedi-vim'
filetype plugin indent on


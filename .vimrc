
"set termencoding=utf-8
"set encoding=utf-8
"set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp

" http://www.kawaz.jp/pukiwiki/?vim#cb691f26
if &encoding !=# 'utf-8'
     set encoding=japan
     set fileencoding=japan
 endif
 if has('iconv')
     let s:enc_euc = 'euc-jp'
     let s:enc_jis = 'iso-2022-jp'
    " iconv��eucJP-ms�ɑΉ����Ă��邩���`�F�b�N
     if iconv("?x87?x64?x87?x6a", 'cp932', 'eucjp-ms') ==# "?xad?xc5?xad?xcb"
         let s:enc_euc = 'eucjp-ms'
         let s:enc_jis = 'iso-2022-jp-3'
    " iconv��JISX0213�ɑΉ����Ă��邩���`�F�b�N
     elseif iconv("?x87?x64?x87?x6a", 'cp932', 'euc-jisx0213') ==# "?xad?xc5?xad?xcb"
         let s:enc_euc = 'euc-jisx0213'
         let s:enc_jis = 'iso-2022-jp-3'
     endif
    " fileencodings���\�z
     if &encoding ==# 'utf-8'
         let s:fileencodings_default = &fileencodings
         let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
         let &fileencodings = &fileencodings .','. s:fileencodings_default
         unlet s:fileencodings_default
     else
         let &fileencodings = &fileencodings .','. s:enc_jis
         set fileencodings+=utf-8,ucs-2le,ucs-2
         if &encoding =~# '^?(euc-jp?|euc-jisx0213?|eucjp-ms?)$'
             set fileencodings+=cp932
             set fileencodings-=euc-jp
             set fileencodings-=euc-jisx0213
             set fileencodings-=eucjp-ms
             let &encoding = s:enc_euc
             let &fileencoding = s:enc_euc
         else
             let &fileencodings = &fileencodings .','. s:enc_euc
         endif
     endif
    " �萔������
     unlet s:enc_euc
     unlet s:enc_jis
 endif

" ���{����܂܂Ȃ��ꍇ�� fileencoding �� encoding ���g���悤�ɂ���
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ���s�R�[�h�̎����F��
set fileformats=unix,dos,mac
" ���Ƃ����̕����������Ă��J�[�\���ʒu������Ȃ��悤�ɂ���
if exists('&ambiwidth')
  set ambiwidth=double
endif


set nowrap
set number
set tabstop=4 shiftwidth=4 softtabstop=0

set backspace=indent,eol,start

syntax on

"set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap

set autoindent
set smartindent

nmap <unique> <silent> <C-S> :BufferExplorer<CR>
nmap <unique> <silent> ef :FilesystemExplorer<CR>

" definition of ignore pattern
set grepprg=grep\ -rnIH\ --exclude-dir=CVS\ --exclude-dir=.svn

call pathogen#runtime_append_all_bundles()

au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 
au BufNewFile,BufRead *.cg,*.fx setf cg

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" Unite.vim
noremap <C-B> :Unite buffer<CR>
noremap <C-F> :Unite -buffer-name=files file<CR>
noremap <C-Z> :Unite file_mru<CR>

aut FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
aut FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')

aut FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
aut FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


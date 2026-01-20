" Remap Shift+J (J) to move down 5 lines
" First unmap the default J (join lines), then remap to 5j
nunmap J
nmap J 5j

" Remap Shift+K (K) to move up 5 lines
" First unmap the default K (usually help/man page), then remap to 5k
nunmap K
nmap K 5k

" Use the system clipboard for yank (y) and paste (p)
" This makes y yank to system clipboard and p paste from system clipboard
set clipboard=unnamed

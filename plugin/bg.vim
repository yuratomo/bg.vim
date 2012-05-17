" File: plugin/bg.vim
" Last Modified: 2012.05.16
" Version: 0.1.0
" Author: yuratomo (twitter @yusetomo)

if exists('g:loaded_bg') && g:loaded_bg == 1
  finish
endif

if !has("autocmd")
  finish
endif

function!  bg#list(A, L, P)
  let items = []
  for cmd in ['grep ', 'cancel']
    if cmd =~ '^'.a:A
      call add(items, cmd)
    endif
  endfor
  return items
endfunction

command! -nargs=* 
  \ -complete=customlist,bg#list
  \ BG :call bg#do(<f-args>)

let g:loaded_bg = 1

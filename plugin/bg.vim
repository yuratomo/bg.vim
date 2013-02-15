" File: plugin/bg.vim
" Last Modified: 2012.05.16
" Version: 0.3.0
" Author: yuratomo (twitter @yusetomo)

if exists('g:loaded_bg') && g:loaded_bg == 1
  finish
endif

if !has("autocmd")
  finish
endif

if !exists('g:bg_message_adjust')
  let g:bg_message_adjust = 10
endif

command! -nargs=* 
  \ -complete=customlist,bg#comp#list
  \ Background
  \ :call bg#do(<f-args>)

let g:loaded_bg = 1

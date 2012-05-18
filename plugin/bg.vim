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

command! -nargs=* 
  \ -complete=customlist,bg#comp#list
  \ Background
  \ :call bg#do(<f-args>)

let g:loaded_bg = 1


let g:bg_completion_items = 
  \[
  \ 'grep ',
  \ 'make ',
  \ 'cancel',
  \]

function!  bg#comp#list(A, L, P)
  let items = []
  for cmd in g:bg_completion_items
    if cmd =~ '^'.a:A
      call add(items, cmd)
    endif
  endfor
  return items
endfunction



function!  bg#api#add_completion(list)
  if !exists('g:bg_completion_items')
    let g:bg_completion_items = []
  endif
  call extend(g:bg_completion_items, a:list)
endfunction


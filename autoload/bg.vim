
function! bg#do(...)
  if !exists('g:loaded_vimproc')
    echoerr "bg.vim is depend on vimproc. Please install it."
    return
  endif

  if len(a:000) == 0
    echo '[usage]'
    echo '  :BG grep grep-args'
    echo '  :BG cancel'
    return
  endif

  if a:000[0] == 'grep'
    call bg#grep(join(a:000[1:], ' '))
  elseif a:000[0] == 'cancel'
    call bg#cancel()
  endif
endfunction

function! bg#grep(...)
  if exists('g:bg')
    call bg#cancel()
  endif

  let g:bg = {}
  let g:bg.pipe = vimproc#popen3(&grepprg . ' ' . join(a:000, ' '))
  if !g:bg.pipe.is_valid
    unlet g:bg
    return
  endif
  let g:bg.updatetime  = &updatetime
  let g:bg.visualbell  = &visualbell
  let g:bg.t_vb        = &t_vb
  let g:bg.total       = 0
  let g:bg.pwd         = expand('%:p:h')
  set updatetime=1000
  set visualbell
  set t_vb=
  redraw
  echo &grepprg . ' ' . join(a:000, ' ')

  augroup bg
    au!
    au! CursorHold * call bg#sync()
  augroup END

endfunction

function! bg#sync()
  if !exists('g:bg')
    return
  endif

  let lines = []
  if g:bg.pipe.is_valid
    let lines = g:bg.pipe.stdout.read_lines()
  endif

  let len = len(lines)
  if len > 0
    "save winow info before change quickfix window
    let old_pwd = expand('%:p:h')
    let old_winno = winnr()

    let lline = 1
    let cline = 1
    let cwinno = 0
    if g:bg.total == 0
      copen
      exe 'cd ' . g:bg.pwd
      let g:bg.bufnr = winbufnr(winnr())
      cgetexpr lines
    else
      let cwinno = bufwinnr(g:bg.bufnr)
      if cwinno != -1
        exe cwinno . 'wincmd w'
        exe 'cd ' . g:bg.pwd
        let lline = line('$')
        let cline = line('.')
        let ccol  = col('.')
      endif
      caddexpr lines
    endif
    let g:bg.total += len

    "change cursor position
    if  cwinno != -1
      if cline == lline
        normal G
      else
        call cursor(cline, ccol)
      endif
    endif

    "restore window info after back old window
    if cwinno != -1
      exe old_winno . "wincmd w"
    endif
    exe 'cd ' . old_pwd
  endif
  echo '[bg] finding now...(' . g:bg.total .')'

  if g:bg.pipe.stdout.eof
    call s:dispose()
  else
    call feedkeys("\<ESC>", 'n')
  endif
endfunction

function! bg#cancel()
  if !exists('g:bg.pipe') || !g:bg.pipe.is_valid
    return
  endif
  call g:bg.pipe.kill(15)
  call s:dispose()
endfunction

function! s:dispose()
  if !exists('g:bg')
    return
  endif

  echo '[bg] find end (total ' . g:bg.total . ')'
  let &updatetime = g:bg.updatetime
  let &visualbell = g:bg.visualbell
  let &t_vb       = g:bg.t_vb

  if g:bg.pipe.is_valid
    call g:bg.pipe.waitpid()
    unlet g:bg.pipe
  endif
  unlet g:bg

  augroup bg
    au!
  augroup END

endfunction


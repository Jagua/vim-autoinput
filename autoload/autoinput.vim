let s:save_cpo = &cpo
set cpo&vim


function! autoinput#start(lines) abort
  call s:putchar(0, 1, 1, a:lines, 0)
endfunction


let s:delay_rules = [
      \ {'char' : '[[:blank:]]', 'delay' : 400},
      \ {'char' : "\n", 'delay' : 1600},
      \ {'char' : '[\.!?]', 'delay' : 600},
      \ {'char' : '.', 'delay' : 200},
      \]


function! s:putchar(delay, lnum, col, lines, _timer_id) abort
  let lnum = a:lnum
  let col = a:col
  let chars = split(a:lines[lnum - 1], '\zs') + ["\n"]
  if len(chars) < col
    return s:putchar(a:delay, lnum + 1, 1, a:lines, 0)
  elseif len(chars) == col && len(a:lines) == lnum
    return
  endif
  let c = chars[col - 1]
  for d in s:delay_rules
    if c =~# d.char
      let delay = d.delay
      break
    endif
  endfor
  call feedkeys(printf("a%s\<Esc>", c))
  call timer_start(delay, function('s:putchar', [delay, lnum, col + 1, a:lines]))
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

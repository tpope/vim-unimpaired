" unimpaired.vim - Pairs of handy bracket mappings
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2
" GetLatestVimScripts: 1590 1 :AutoInstall: unimpaired.vim

if exists("g:loaded_unimpaired") || &cp || v:version < 700
  finish
endif
let g:loaded_unimpaired = 1

function! s:map(mode, lhs, rhs, ...) abort
  let flags = (a:0 ? a:1 : '') . (a:rhs =~# '^<Plug>' ? '' : '<script>')
  let head = a:lhs
  let tail = ''
  let keys = get(g:, a:mode.'remap', {})
  if type(keys) != type({})
    return
  endif
  while !empty(head)
    if has_key(keys, head)
      let head = keys[head]
      if empty(head)
        return
      endif
      break
    endif
    let tail = matchstr(head, '<[^<>]*>$\|.$') . tail
    let head = substitute(head, '<[^<>]*>$\|.$', '', '')
  endwhile
  exe a:mode.'map' flags head.tail a:rhs
endfunction

" Next and previous {{{1

function! s:MapNextFamily(map,cmd) abort
  let map = '<Plug>unimpaired'.toupper(a:map)
  let cmd = '".(v:count ? v:count : "")."'.a:cmd
  let end = '"<CR>'.(a:cmd == 'l' || a:cmd == 'c' ? 'zv' : '')
  execute 'nnoremap <silent> '.map.'Previous :<C-U>exe "'.cmd.'previous'.end
  execute 'nnoremap <silent> '.map.'Next     :<C-U>exe "'.cmd.'next'.end
  execute 'nnoremap <silent> '.map.'First    :<C-U>exe "'.cmd.'first'.end
  execute 'nnoremap <silent> '.map.'Last     :<C-U>exe "'.cmd.'last'.end
  call s:map('n', '['.        a:map , map.'Previous')
  call s:map('n', ']'.        a:map , map.'Next')
  call s:map('n', '['.toupper(a:map), map.'First')
  call s:map('n', ']'.toupper(a:map), map.'Last')
  if exists(':'.a:cmd.'nfile')
    execute 'nnoremap <silent> '.map.'PFile :<C-U>exe "'.cmd.'pfile'.end
    execute 'nnoremap <silent> '.map.'NFile :<C-U>exe "'.cmd.'nfile'.end
    call s:map('n', '[<C-'.toupper(a:map).'>', map.'PFile')
    call s:map('n', ']<C-'.toupper(a:map).'>', map.'NFile')
  endif
endfunction

call s:MapNextFamily('a','')
call s:MapNextFamily('b','b')
call s:MapNextFamily('l','l')
call s:MapNextFamily('q','c')
call s:MapNextFamily('t','t')

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

nnoremap <silent> <Plug>unimpairedDirectoryNext     :<C-U>edit <C-R>=<SID>fnameescape(fnamemodify(unimpaired#FileByOffset(v:count1), ':.'))<CR><CR>
nnoremap <silent> <Plug>unimpairedDirectoryPrevious :<C-U>edit <C-R>=<SID>fnameescape(fnamemodify(unimpaired#FileByOffset(-v:count1), ':.'))<CR><CR>
call s:map('n', ']f', '<Plug>unimpairedDirectoryNext')
call s:map('n', '[f', '<Plug>unimpairedDirectoryPrevious')

nmap <silent> <Plug>unimpairedONext     <Plug>unimpairedDirectoryNext:echohl WarningMSG<Bar>echo "]o is deprecated. Use ]f"<Bar>echohl NONE<CR>
nmap <silent> <Plug>unimpairedOPrevious <Plug>unimpairedDirectoryPrevious:echohl WarningMSG<Bar>echo "[o is deprecated. Use [f"<Bar>echohl NONE<CR>
call s:map('n', ']o', '<Plug>unimpairedONext')
call s:map('n', '[o', '<Plug>unimpairedOPrevious')

" }}}1
" Diff {{{1

call s:map('n', '[n', '<Plug>unimpairedContextPrevious')
call s:map('n', ']n', '<Plug>unimpairedContextNext')
call s:map('o', '[n', '<Plug>unimpairedContextPrevious')
call s:map('o', ']n', '<Plug>unimpairedContextNext')

nnoremap <silent> <Plug>unimpairedContextPrevious :call unimpaired#Context(1)<CR>
nnoremap <silent> <Plug>unimpairedContextNext     :call unimpaired#Context(0)<CR>
onoremap <silent> <Plug>unimpairedContextPrevious :call unimpaired#ContextMotion(1)<CR>
onoremap <silent> <Plug>unimpairedContextNext     :call unimpaired#ContextMotion(0)<CR>


" }}}1
" Line operations {{{1

nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>call unimpaired#BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>call unimpaired#BlankDown(v:count1)<CR>

call s:map('n', '[<Space>', '<Plug>unimpairedBlankUp')
call s:map('n', ']<Space>', '<Plug>unimpairedBlankDown')

nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call unimpaired#Move('--',v:count1,'Up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call unimpaired#Move('+',v:count1,'Down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call unimpaired#MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call unimpaired#MoveSelectionDown(v:count1)<CR>

call s:map('n', '[e', '<Plug>unimpairedMoveUp')
call s:map('n', ']e', '<Plug>unimpairedMoveDown')
call s:map('x', '[e', '<Plug>unimpairedMoveSelectionUp')
call s:map('x', ']e', '<Plug>unimpairedMoveSelectionDown')

" }}}1
" Option toggling {{{1

function! s:option_map(letter, option, mode) abort
  call s:map('n', '[o'.a:letter, ':'.a:mode.' '.a:option.'<C-R>=unimpaired#statusbump()<CR><CR>')
  call s:map('n', ']o'.a:letter, ':'.a:mode.' no'.a:option.'<C-R>=unimpaired#statusbump()<CR><CR>')
  call s:map('n', '=o'.a:letter, ':'.a:mode.' <C-R>=unimpaired#toggle("'.a:option.'")<CR><CR>')
endfunction

call s:map('n', '[ob', ':set background=light<CR>')
call s:map('n', ']ob', ':set background=dark<CR>')
call s:map('n', '=ob', ':set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>')
call s:option_map('c', 'cursorline', 'setlocal')
call s:option_map('u', 'cursorcolumn', 'setlocal')
call s:map('n', '[od', ':diffthis<CR>')
call s:map('n', ']od', ':diffoff<CR>')
call s:map('n', '=od', ':<C-R>=&diff ? "diffoff" : "diffthis"<CR><CR>')
call s:option_map('h', 'hlsearch', 'set')
call s:option_map('i', 'ignorecase', 'set')
call s:option_map('l', 'list', 'setlocal')
call s:option_map('n', 'number', 'setlocal')
call s:option_map('r', 'relativenumber', 'setlocal')
call s:option_map('s', 'spell', 'setlocal')
call s:option_map('w', 'wrap', 'setlocal')
call s:map('n', '[ov', ':set virtualedit+=all<CR>')
call s:map('n', ']ov', ':set virtualedit-=all<CR>')
call s:map('n', '=ov', ':set <C-R>=(&virtualedit =~# "all") ? "virtualedit-=all" : "virtualedit+=all"<CR><CR>')
call s:map('n', '[ox', ':set cursorline cursorcolumn<CR>')
call s:map('n', ']ox', ':set nocursorline nocursorcolumn<CR>')
call s:map('n', '=ox', ':set <C-R>=unimpaired#cursor_options()<CR><CR>')
if empty(maparg('co', 'n'))
  nmap co =o
endif

nnoremap <silent> <Plug>unimpairedPaste :call unimpaired#setup_paste()<CR>

call s:map('n', 'yo', ':call unimpaired#setup_paste()<CR>o', '<silent>')
call s:map('n', 'yO', ':call unimpaired#setup_paste()<CR>O', '<silent>')

" }}}1
" Put {{{1

nnoremap <silent> <Plug>unimpairedPutAbove :call unimpaired#putline('[p', 'Above')<CR>
nnoremap <silent> <Plug>unimpairedPutBelow :call unimpaired#putline(']p', 'Below')<CR>

call s:map('n', '[p', '<Plug>unimpairedPutAbove')
call s:map('n', ']p', '<Plug>unimpairedPutBelow')
call s:map('n', '>P', ":call unimpaired#putline('[p', 'Above')<CR>>']", '<silent>')
call s:map('n', '>p', ":call unimpaired#putline(']p', 'Below')<CR>>']", '<silent>')
call s:map('n', '<P', ":call unimpaired#putline('[p', 'Above')<CR><']", '<silent>')
call s:map('n', '<p', ":call unimpaired#putline(']p', 'Below')<CR><']", '<silent>')
call s:map('n', '=P', ":call unimpaired#putline('[p', 'Above')<CR>=']", '<silent>')
call s:map('n', '=p', ":call unimpaired#putline(']p', 'Below')<CR>=']", '<silent>')

" }}}1
" Encoding and decoding {{{1

function! UnimpairedMapTransform(algorithm, key) abort
  exe 'nnoremap <silent> <Plug>unimpaired_'    .a:algorithm.' :<C-U>call unimpaired#TransformSetup("'.a:algorithm.'")<CR>g@'
  exe 'xnoremap <silent> <Plug>unimpaired_'    .a:algorithm.' :<C-U>call unimpaired#Transform("'.a:algorithm.'",visualmode())<CR>'
  exe 'nnoremap <silent> <Plug>unimpaired_line_'.a:algorithm.' :<C-U>call unimpaired#Transform("'.a:algorithm.'",v:count1)<CR>'
  call s:map('n', a:key, '<Plug>unimpaired_'.a:algorithm)
  call s:map('x', a:key, '<Plug>unimpaired_'.a:algorithm)
  call s:map('n', a:key.a:key[strlen(a:key)-1], '<Plug>unimpaired_line_'.a:algorithm)
endfunction

call UnimpairedMapTransform('string_encode','[y')
call UnimpairedMapTransform('string_decode',']y')
call UnimpairedMapTransform('url_encode','[u')
call UnimpairedMapTransform('url_decode',']u')
call UnimpairedMapTransform('xml_encode','[x')
call UnimpairedMapTransform('xml_decode',']x')

" }}}1

" vim:set sw=2 sts=2:

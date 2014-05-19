let s:history = []

function! s:append_to_file(file, lines)
  if filereadable(a:file)
    call writefile(readfile(a:file)+a:lines, a:file)
  else
    call writefile(["name,key,command,datetime"] + a:lines, a:file)
  end
endfunction

function! leaderboard#noremap(name, key, ...)
  let acc = '["' . join(a:000, '","') . '"]'

  let f = "noremap <leader>" . a:key . " :call leaderboard#add_entry(\"" . a:name . "\", \"" . a:key . "\", " . acc . ")<cr>"
  execute f
endfunction

function! leaderboard#add_entry(name, key, cmds)
  call add(s:history, '"' . a:name . '","' . a:key . '","' . join(a:cmds, " ") . '","' . strftime('%c') . '"')

  for cmd in a:cmds
    execute cmd
  endfor
endfunction

function! s:save()
  call s:append_to_file(expand("~/.leaderboard_hist"), s:history)
endfunction

augroup leaderboard#save_history
  autocmd!
  autocmd VimLeave * call s:save()
augroup END


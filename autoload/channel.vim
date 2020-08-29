function! channel#connect(host, ...)
  if a:0
    return sockconnect('tcp', a:host, {'on_data': a:1})
  endif

  return sockconnect('tcp', a:host)
endfunction

function! channel#send(channel, cmd)
  let g:status = 'no' 
  call chansend(a:channel, a:cmd)

  return 'done'
endfunction

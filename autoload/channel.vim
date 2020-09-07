function! channel#connect(host, ...)
  if a:0 && has('nvim')
    return sockconnect('tcp', a:host, {'on_data': a:1})
  endif

  if has('nvim')
    return sockconnect('tcp', a:host)
  end

  return ch_open(a:host)
endfunction

function! channel#send(channel, cmd, ...)
  let g:status = 'no' 

  if has('nvim')
    call chansend(a:channel, a:cmd)
    return 'done'
  end

  call ch_sendraw(a:channel, a:cmd)
  return 'done'
endfunction

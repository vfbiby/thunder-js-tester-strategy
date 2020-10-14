function! ReceiveStatus(...)
  let g:status = 'ok'
endfunction

function! ConnectToMochaServer()
  let g:channel_id = channel#autoconnect(function('ReceiveStatus'))
endfunction

function! WaitForResponse()
  if has('nvim')
    sleep 10m
  else
    if ch_readraw(g:channel_id, {'timeout': 10}) ==# 'ok'
      let g:status = 'ok'
    endif
  endif
endfunction

function! strategy#JavascriptMochaStratey(cmd)
  if !exists('g:channel_id')
    call ConnectToMochaServer()
  end

  let json_cmd = command#transform(a:cmd)
  call channel#send(g:channel_id, json_cmd)

  call WaitForResponse()

  "wait for server respose
  if g:status !=# 'ok'
    call ConnectToMochaServer()
    call channel#send(g:channel_id, json_cmd)
    call WaitForResponse()
  end
endfunction

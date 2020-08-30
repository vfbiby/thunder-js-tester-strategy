function! ReceiveStatus(...)
  let g:status = a:2[0]
endfunction

function! ConnectToMochaServer()
  let g:channel_id = channel#connect('localhost:40123', function('ReceiveStatus'))
endfunction

call ConnectToMochaServer()

function! JavascriptMochaStratey(cmd)
  if !g:channel_id
    call ConnectToMochaServer()
  end

  let json_cmd = command#transform(a:cmd)
  call channel#send(g:channel_id, json_cmd)

  "wait for server respose
  sleep 10m
  if g:status !=# 'ok'
    call ConnectToMochaServer()
    call channel#send(g:channel_id, json_cmd)
    sleep 10m
  end
endfunction

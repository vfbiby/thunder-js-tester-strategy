function! ReceiveStatus(...)
  let g:status = 'ok'
endfunction

function! JavascriptMochaStratey(cmd)
  let channel = channel#connect('localhost:40123', function('ReceiveStatus'))
  let json_cmd = command#transform(a:cmd)
  call channel#send(channel, json_cmd)
endfunction

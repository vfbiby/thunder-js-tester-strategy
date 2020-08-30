function! ReceiveStatus(...)
  let g:status = a:2[0]
endfunction

let g:channel_id = channel#connect('localhost:40123', function('ReceiveStatus'))

function! JavascriptMochaStratey(cmd)
  if !g:channel_id
    let g:channel_id = channel#connect('localhost:40123', function('ReceiveStatus'))
  end

  let json_cmd = command#transform(a:cmd)
  call channel#send(g:channel_id, json_cmd)

  if g:status !=# 'ok'
    let g:channel_id = channel#connect('localhost:40123', function('ReceiveStatus'))
    call channel#send(g:channel_id, json_cmd)
  end
endfunction

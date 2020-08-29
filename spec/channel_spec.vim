describe 'channel'

  it 'can connect to an available host:port server' 
    let channel = channel#connect('localhost:40123')
    Expect channel > 0
  end

  it 'will get a exception when connect a unavailable host:port server' 
    Expect expr { channel#connect('localhost:40124') } to_throw 'connection refused'
  end

  it 'can send a cmd to connected server and return a done status'
    let channel = channel#connect('localhost:40123')
    let send_status = channel#send(channel, '{"type":"file", "file":"__tests__/search.spec.js"}')

    Expect send_status == 'done'
  end

  it 'will set status to no when send any command'
    let g:status = ''
    let channel = channel#connect('localhost:40123')
    call channel#send(channel, '{"type":"file", "file":"__tests__/search.spec.js"}')

    Expect g:status == 'no'
  end

  it 'can set a callback function to receive response when server get the cmd'
    let g:status = ''

    function! ReceiveStatus(...)
      let g:status = 'ok'
    endfunction

    let channel = channel#connect('localhost:40123', function('ReceiveStatus'))
    call channel#send(channel, '{"type":"file", "file":"__tests__/search.spec.js"}')
    sleep 10m

    Expect g:status ==# 'ok'
  end

end

describe 'connect'

  before
    let g:status = ''
    function! ReceiveStatus(...)
      let g:status = 'ok'
    endfunction
  end

  after
    if file_readable('.mochaserverrc.js')
      call delete('.mochaserverrc.js')
    endif
  end

  it 'will get error when connect default localhost:40123 if has no .mochaserverrc.js if default host is not available'
    Expect expr { channel#autoconnect(function('ReceiveStatus')) } to_throw 'connection refused'
  end

  it 'will connect the host that stored inn .mochaserverrc.js'
    call writefile([json_encode({'port': 40124})], '.mochaserverrc.js')

    Expect channel#autoconnect(function('ReceiveStatus')) > 0
  end

  it 'can pass callback to next func'
    call writefile([json_encode({'port': 40124})], '.mochaserverrc.js')
    
    let g:status = ''
    let channel_id = channel#autoconnect(function('ReceiveStatus'))
    Expect channel_id > 0
    call channel#send(channel_id, json_encode({'file': 'somefile'}))
    Expect g:status ==# 'no'

    sleep 100m
    Expect g:status ==# 'ok'

  end
end

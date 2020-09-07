source spec/help.vim

describe 'in vim g:channel'

  before
    let g:channel = channel#connect('localhost:40123')
  end

  it 'can connect to an available host:port server' 
    call SkipTestInNeovim()
    Expect ch_status(g:channel) == 'open'
  end

  it 'will get a exception when connect a unavailable host:port server' 
    call SkipTestInNeovim()
    Expect ch_status(channel#connect('localhost:40124')) == 'fail'
  end

  it 'can send a cmd to connected server and return a done status'
    call SkipTestInNeovim()
    let send_status = channel#send(g:channel, '{"type":"file", "file":"__tests__/search.spec.js"}')

    Expect send_status == 'done'
  end

  it 'will set status to no when send any command'
    call SkipTestInNeovim()
    let g:status = ''
    call channel#send(g:channel, '{"type":"file", "file":"__tests__/search.spec.js"}')

    Expect g:status == 'no'
  end

  it 'can set a callback function to receive response when server get the cmd'
    call SkipTestInNeovim()
    let g:status = ''

    call channel#send(g:channel, '{"type":"file", "file":"__tests__/search.spec.js"}')
    Expect g:status == 'no'

    let g:status = ch_readraw(g:channel, {'timeout': 10})
    Expect g:status ==# 'ok'
  end

end

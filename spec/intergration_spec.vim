describe 'thunder js tester strategy'

  before
    function! ReceiveStatus(...)
      let g:status = 'ok'
    endfunction
  end

  it 'can connect tester server and send test command'
    let channel = channel#connect('localhost:40123', function('ReceiveStatus'))
    let json_cmd = command#transform('mocha __tests__/search.spec.js')
    let send_status = channel#send(channel, json_cmd)
    Expect send_status == 'done'
    Expect g:status == 'no'

    sleep 10m
    Expect g:status == 'ok'
  end

end

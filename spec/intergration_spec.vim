source plugin/js-strategy.vim

describe 'thunder js tester strategy'

  it 'can connect tester server and send test command'
    let channel = channel#connect('localhost:40123', function('ReceiveStatus'))
    let json_cmd = command#transform('mocha __tests__/search.spec.js')
    let send_status = channel#send(channel, json_cmd)
    Expect send_status == 'done'
    Expect g:status == 'no'

    "wait for server respose
    sleep 10m 

    Expect g:status == 'ok'
  end

  it 'will reconnect to mocha server when responsed status is not ok'
    let g:status = ''
    call JavascriptMochaStratey('mocha __tests__/search.spec.js')
    Expect g:status == 'ok'

    "tell the server to close the connection
    call channel#send(g:channel_id, 'close connection!') 

    let g:status = ''
    call JavascriptMochaStratey('mocha __tests__/search.spec.js')
    Expect g:status == 'ok'
  end
end

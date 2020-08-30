source plugin/js-strategy.vim

describe 'thunder js tester strategy'

  it 'can connect tester server and send test command'
    let channel = channel#connect('localhost:40123', function('ReceiveStatus'))
    let json_cmd = command#transform('mocha __tests__/search.spec.js')
    let send_status = channel#send(channel, json_cmd)
    Expect send_status == 'done'
    Expect g:status == 'no'

    sleep 10m "wait for server respose
    Expect g:status == 'ok'
  end

  it 'will reconnect to mocha server when responsed status is not ok'
    call JavascriptMochaStratey('mocha __tests__/search.spec.js')
    Expect g:status == 'no'

    sleep 10m "wait for server respose
    Expect g:status == 'ok'

    call channel#send(g:channel_id, 'close connection!')
    call JavascriptMochaStratey('mocha __tests__/search.spec.js')
    Expect g:status == 'no'

    sleep 10m "wait for server respose
    Expect g:status == 'ok'
  end
end

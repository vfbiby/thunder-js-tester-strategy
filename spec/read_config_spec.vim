describe 'config'
  before
    call writefile(
          \[json_encode({ 'port': 40124 })],
          \'.mochaserverrc.js'
          \)
  end

  after
    call delete('.mochaserverrc.js')
  end

  it 'can read from json file'
    let config = join(readfile('.mochaserverrc.js'))

    Expect config ==# "{\"port\": 40124}"
  end

  it 'can decode rc file'
    let config = json_decode(readfile('.mochaserverrc.js'))

    Expect config['port'] == 40124
  end

  it 'can check if a file is readable'
    Expect  filereadable('.mochaserverrc.js') ==# 1
    Expect  filereadable('file_not_exists') ==# 0
  end

  it 'can write encoded json'
    let info = { 'port': 40123 }

    Expect json_encode(info) == "{\"port\": 40123}"
  end

end

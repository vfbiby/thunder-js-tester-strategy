describe 'write json'
  before
    let g:filename = 'test_write.jse'
  end

  after
    call delete(g:filename)
  end

  it 'can write a json to file'
    call writefile(
          \[json_encode({ 'port': 40123 })],
          \g:filename
          \)

    Expect join(readfile('test_write.jse')) ==# "{\"port\": 40123}"
  end
end

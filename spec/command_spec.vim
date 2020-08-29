describe 'Command'

  it 'can transform vim-test mochas file test cmd to a json command'
    let mocha_cmd = 'mocha __tests__/search.spec.js'
    let json_cmd = "{\"type\":\"file\", \"file\":\"__tests__/search.spec.js\"}"

    Expect json_cmd ==# command#transform(mocha_cmd)
  end
  
end

describe 'Command'

  it 'can transform vim-test mochas file test cmd to a json command'
    let origin_mocha_cmd = 'mocha __tests__/search.spec.js'
    let expected_json_cmd = "{\"type\":\"file\", \"file\":\"__tests__/search.spec.js\"}"

    Expect command#transform(origin_mocha_cmd) ==# expected_json_cmd
  end

  it 'can transform vim-test mochas title test cmd to a json command'
    let origin_mocha_cmd = 'mocha __tests__/search.spec.js --grep ''^Math Addition adds two numbers$'''
    let expected_json_cmd = "{\"type\":\"file\", \"file\":\"__tests__/search.spec.js\" , \"title\":\"Math Addition adds two numbers\"}"
    
    Expect command#transform(origin_mocha_cmd) ==# expected_json_cmd
  end
  
  it 'can transform vim-test mochas suite test cmd to a json command'
    let origin_mocha_cmd = 'mocha __tests__/*.spec.js'
    let expected_json_cmd = "{\"type\":\"allfile\"}"
    
    Expect command#transform(origin_mocha_cmd) ==# expected_json_cmd
  end

end

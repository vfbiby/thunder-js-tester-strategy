describe 'Command'
  it "can get file path which come from a simple file specified test mocha command"
    let origin_mocha_cmd = 'mocha src/search.spec.js'
    let expected_file_name = 'src/search.spec.js'

    Expect command#getFileName(origin_mocha_cmd) ==# expected_file_name
  end

  it "can get file path which come from a title specified test mocha command"
    let origin_mocha_cmd = 'mocha __tests__/search.spec.js --grep ''^Math Addition adds two numbers$'''
    let expected_file_name =  '__tests__/search.spec.js'

    Expect command#getFileName(origin_mocha_cmd) ==# expected_file_name
  end

  it "can get title"
    let origin_mocha_cmd = 'mocha __tests__/search.spec.js --grep ''^Math Addition adds two numbers$'''
    let expected_title = 'Math Addition adds two numbers'

    Expect command#getTitle(origin_mocha_cmd) ==# expected_title
  end
end

function! command#transform(cmd)
  let pattern = '__tests__.*.js'
  let testFileName =  matchstr(a:cmd, pattern)
  let testTitle = matchstr(a:cmd, '\^.*\$')[1:-2]
  let testSuite = matchstr(testFileName, '*..*.js')

  if strlen(testTitle) != 0
    return "{\"type\":\"file\", \"file\":\"". testFileName ."\" , \"title\":\"". testTitle ."\"}"        
  end

  if strlen(testSuite) != 0
    return "{\"type\":\"allfile\"}"        
  end

  return "{\"type\":\"file\", \"file\":\"". testFileName ."\"}"        
endfunction

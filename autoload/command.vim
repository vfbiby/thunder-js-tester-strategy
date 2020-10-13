function! command#transform(cmd)
  let testFileName =  command#getFileName(a:cmd)
  let testTitle = command#getTitle(a:cmd)
  let testSuite = matchstr(testFileName, '*..*.js')

  if strlen(testTitle) != 0
    return "{\"type\":\"file\", \"file\":\"". testFileName ."\" , \"title\":\"". testTitle ."\"}"        
  end

  if strlen(testSuite) != 0
    return "{\"type\":\"allfile\"}"        
  end

  return "{\"type\":\"file\", \"file\":\"". testFileName ."\"}"        
endfunction

function command#getFileName(cmd)
  return split(a:cmd)[1]
endfunction

function command#getTitle(cmd)
  return matchstr(a:cmd, '\^.*\$')[1:-2]
endfunction

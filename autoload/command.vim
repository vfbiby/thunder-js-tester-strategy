function! command#transform(cmd) abort
  let pattern = '__tests__.*.js'
  let testFileName =  matchstr(a:cmd, pattern)
  return "{\"type\":\"file\", \"file\":\"". testFileName ."\"}"        
endfunction

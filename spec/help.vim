function SkipTestInNeovim()
  if has('nvim')
    SKIP 'this test should run in neovim not in vim'
  endif
endfunction

function SkipTestInVim()
  if !has('nvim')
    SKIP 'this test should run in vim not in vim'
  endif
endfunction

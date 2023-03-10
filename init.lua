-- bootstrap lazy.nvim, LazyVim and your plugins
vim.cmd([[
  if $CONDA_PREFIX ==? '/home/tudor/.mambaf'
      if $VIRTUAL_ENV !=? ''
        let g:current_python_path=$VIRTUAL_ENV.'/bin/python'
    else
        let g:current_python_path=$CONDA_EXE
    endif
  else
    let g:current_python_path=$CONDA_PREFIX.'/bin/python'
  endif
]])
require("config.lazy")

-- bootstrap lazy.nvim, LazyVim and your plugins
vim.cmd([[let g:python3_host_prog = '/home/tudor/.mamba/bin/python3']])
vim.cmd([[
  if $CONDA_PREFIX ==? '/home/tudor/.mamba'
      if $VIRTUAL_ENV ==? ''
        let g:current_python_path=$CONDA_PYTHON_EXE
    else
        let g:current_python_path=$VIRTUAL_ENV.'/bin/python'
    endif
  else
    let g:current_python_path=$CONDA_PREFIX.'/bin/python'
  endif
]])
require("config.lazy")

vim.api.nvim_create_user_command('Tag', function(opts)
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local tag = opts.args
  local lines = {'<' .. tag .. '>', '</' .. tag .. '>'}
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end, { nargs = 1 })

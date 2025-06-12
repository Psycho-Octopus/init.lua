vim.api.nvim_create_user_command('Htmx', function()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local lines = {'<script src="https://unpkg.com/htmx.org@1.9.12"></script>'}
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end, {})

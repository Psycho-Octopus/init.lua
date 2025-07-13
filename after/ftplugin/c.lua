vim.keymap.set(
  'n',
  '<leader>ll',
  'olua_State *L = luaL_newstate();<Esc>oluaL_openlibs(L);<Esc>o<CR>lua_close(L);')

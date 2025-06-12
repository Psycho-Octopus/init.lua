-- Setup lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- init.lua:
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
  
  {
    "mason-org/mason.nvim",
    opts = {}
  },
	
  { "mbbill/undotree" },

  { "RRethy/nvim-treesitter-endwise" },

  { "alec-gibson/nvim-tetris" },
  -- Colorscheme
  { "rose-pine/neovim", name = "rose-pine" },

  -- File explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      }
    end,
  },

  -- Required for dap-ui
  { "nvim-neotest/nvim-nio" },

  -- DAP: Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.readapt = {
        type = "executable",
        command = "readapt",
        args = {},
      }
      dap.configurations.ruby = {
        {
          type = "readapt",
          request = "launch",
          name = "Debug current file",
          program = "${file}",
          useBundler = false,
        },
      }
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },

  -- DAP virtual text
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- Autocompletion engine and sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Optionally keep LSP config (you can remove this if you're using only `vim.lsp.enable`)
  {
    "neovim/nvim-lspconfig",
  },
})

-- General Neovim options
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = ""
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Colorscheme
vim.cmd.colorscheme("rose-pine")

vim.lsp.enable("solargraph")
vim.lsp.enable("gopls")

-- Keybindings
vim.g.mapleader = " "
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', vim.cmd.UndotreeToggle)
vim.keymap.set('n', "<C-m>", ":InspectTree", { noremap = true, silent = true})

-- NvimTree setup
require("nvim-tree").setup({
  view = { width = 30, side = "left" },
  renderer = { icons = { show = { folder_arrow = true } } },
})

-- DAP keybindings
local dap = require("dap")
vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)
vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint() end)
vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end)

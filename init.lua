require("set")
require("keys")
-- require("cursor")
-- require("lua.ctaylor.hardmode")
-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  { "CRAG666/code_runner.nvim", config = true },

  {
  "github/copilot.vim",
--  event = "InsertEnter", -- lazy-load on insert
  enabled = false,
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
  end,
},
    {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon"):setup({
        -- optional settings
        settings = { save_on_toggle = true },
      })

      vim.keymap.set("n", "<C-a>", function() harpoon: list():add() end)
      vim.keymap.set("n", "<C-m>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<C-l>", function() harpoon:list():remove(selected_entry) end)
    end,
  },
  { "ya2s/nvim-cursorline" },
  {
  "theHamsta/nvim-dap-virtual-text",
  dependencies = {"mfussenegger/nvim-dap"},
  config = function()
    require("nvim-dap-virtual-text").setup {
      commented = true, -- adds comments like "-- value" next to variables
    }
  end
},
-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
{
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    }
},
  {
  'stevearc/conform.nvim',
  opts = {},
},

  {
  "j-hui/fidget.nvim",
  opts = {
    -- options
  },
  },

 {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

{
  "folke/zen-mode.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},

  {
  "karb94/neoscroll.nvim",
  opts = {},
},


  { "m4xshen/autoclose.nvim" },


  {
  'stevearc/overseer.nvim',
  opts = {},
  },

  { 'norcalli/nvim-colorizer.lua' },

  { "tpope/vim-fugitive" },

  { "alec-gibson/nvim-tetris" },

  {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
},

{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},

{
  'stevearc/dressing.nvim',
  opts = {},
},

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
    },
    config = function()
      require('nvim-tree').setup()
    end
  },
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
},

  -- theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
    end,
  },
  {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {},
},

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "horizontal",
      size = 40,
      open_mapping = [[<C-\>]],
      start_in_insert = true,
      persist_size = true,
      shade_terminals = false,
    })

    vim.api.nvim_create_user_command("Term", function()
      require("toggleterm.terminal").Terminal
        :new({ direction = "horizontal", hidden = false }):toggle()
    end, {})
  end,
},

  -- emmet for templating
  {
  "mattn/emmet-vim",
  ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  init = function()
    vim.g.user_emmet_leader_key = '<C-e>'
  end
},
  {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},


  -- LSP config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "solargraph", "ts_ls", "html", "cssls", "clangd" },
      })

      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
  local opts = { capabilities = capabilities }

  if server == "lua_ls" then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }, -- avoid 'undefined global vim'
          unusedLocalExclude = { "_*" }, -- ignore `_foo` style unused warnings
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    }
  end

  lspconfig[server].setup(opts)
end

    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "lua", "ruby", "javascript", "html", "css", "c" },
      })
    end,
  },

  {
    "mbbill/undotree",
    config = function()
      vim.opt.undofile = true
      vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir"
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
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
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
{ 
    "nvim-lualine/lualine.nvim",
    enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
    })
  end,
},
})
-- color
vim.cmd[[colorscheme rose-pine]]

require('nvim-tree').setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
-- autoclose setup
require("autoclose").setup()

-- overseer setup
require('overseer').setup()

-- indent setup
require("ibl").setup({
    indent = {
        char = "│",
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "IndentBlanklineChar" },  -- <- a guaranteed existing group
        include = {
            node_type = {
                lua = { "function", "table_constructor", "if_statement" },
                python = { "function_definition", "class_definition" },
                ruby = { "method", "class", "module" },
                -- Add more languages if needed
            },
        },
    },
    exclude = {
        filetypes = { "help", "packer", "nvimtree", "dashboard", "neo-tree" },
        buftypes = { "terminal", "nofile", "quickfix" },
    },
})

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "◆",  -- could be "●", "■", "◆", "▶", etc
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

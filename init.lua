require("set")
require("keys")
require("cursor")

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
{
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("ctaylor.alpha")
  end,
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
        lspconfig[server].setup({
          capabilities = capabilities,
        })
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
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
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

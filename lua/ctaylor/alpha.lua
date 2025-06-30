local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Just the full ASCII logo as the header
-- No buttons, no footer

dashboard.section.header.val = {
  "NEOVIM"
}

dashboard.section.buttons.val = {
  dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
  dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
  dashboard.button("g", "  Find Text", ":Telescope live_grep <CR>"),
}
dashboard.opts.opts.margin = 5

dashboard.section.footer.val = ""

alpha.setup(dashboard.opts)

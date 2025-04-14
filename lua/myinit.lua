local api = vim.api

vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title

vim.opt.clipboard = "unnamedplus"

vim.notify = require "notify"

api.nvim_create_autocmd(
  "BufEnter",
  { pattern = "*", command = 'let &titlestring = "nvim " .. system(\'pwd | sed "s#.*/##"\') .. " - " .. expand("%:t")' }
)
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    require("cmp").setup.buffer { sources = { { name = "crates" } } }
  end,
})

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

vim.opt.conceallevel = 1

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

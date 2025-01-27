local api = vim.api

vim.opt.title = true

vim.opt.clipboard = "unnamedplus"

api.nvim_create_autocmd(
  "BufEnter",
  { pattern = "*", command = 'let &titlestring = system(\'pwd | sed "s#.*/##"\') .. " - " .. expand("%:t")' }
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
vim.g.neovide_scale_factor = 1.5
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_refresh_rate = 120

if vim.g.neovide == true then
  vim.api.nvim_set_keymap(
    "n",
    "<C-=>",
    ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  5.0)<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<C-->",
    ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 2<CR>", { silent = true })
end

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

local api = vim.api

vim.opt.title = true

vim.opt.clipboard = "unnamedplus"

api.nvim_create_autocmd("BufEnter", { pattern='*', command = 'let &titlestring = system(\'pwd | sed "s#.*/##"\') .. " - " .. expand("%:t")'})
vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
        require("cmp").setup.buffer({ sources = { { name = "crates" } } })
    end,
})

vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

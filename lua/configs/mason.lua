local merge_tb = vim.tbl_deep_extend
local defaults = require "nvchad.configs.mason"

local opts = {
  ensure_installed = {
    "pyright",
    "typescript-language-server",
    "lua-language-server",
    "vue-language-server",
    "prettier",
    -- "eslint",
    "clangd",
    "codelldb",
    "bash-language-server",
    "bash-debug-adapter",
    "yamlls",
  }, -- not an option from mason.nvim
  max_concurrent_installers = 10,
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
end, {})

return merge_tb("force", defaults, opts)

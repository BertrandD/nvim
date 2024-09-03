return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,
    ft = { 'rust' },
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local configs = require("nvchad.configs.lspconfig")
      local on_attach = configs.on_attach

      vim.g.rustaceanvim = {
        dap = {
          autoload_configurations = true
        },
        server = {
          on_attach = on_attach
        }
      }
    end
  },
  {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function()
      require('crates').setup()
    end,
  },
}

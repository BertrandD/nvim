return {
  {
    "mrcjkb/rustaceanvim",
    version = "^7", -- Recommended
    lazy = false,
    ft = { "rust" },
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local configs = require "nvchad.configs.lspconfig"
      local on_attach = configs.on_attach

      vim.g.rustaceanvim = {
        dap = {
          autoload_configurations = true,
        },
        server = {
          on_attach = on_attach,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                targetDir = "/home/bertrand/tmp/cargo-target-ra",
              },
            },
          },
        },
      }
    end,
  },
  {
    "ron-rs/ron.vim",
    lazy = false,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    dependencies = {
      'towolf/vim-helm'
    },
    -- opts = {
    --   setup = {
    --     rust_analyzer = function()
    --       return true
    --     end,
    --   },
    -- },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- "rust-analyzer",
        "pyright",
        "typescript-language-server",
        "lua-language-server",
        -- "eslint",
        "clangd",
        "codelldb",
        "bash-language-server",
        "bash-debug-adapter"
      },
      PATH = "prepend"
    }
  },
}

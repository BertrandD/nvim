return {
  {
    "neovim/nvim-lspconfig",
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    dependencies = {
      "towolf/vim-helm",
      "kevinhwang91/nvim-ufo",
    },
    -- opts = {
    --   setup = {
    --     rust_analyzer = function()
    --       return true
    --     end,
    --   },
    -- },
  },
  { "sbdchd/neoformat" },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
}

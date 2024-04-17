return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",               -- required
      "nvim-telescope/telescope.nvim",       -- optional
      "sindrets/diffview.nvim",              -- optional
      "ibhagwan/fzf-lua",                    -- optional
    },
    cmd = {
      "Neogit"
    },
    config = function()
      require("neogit").setup({
        kind = "vsplit",                            -- opens neogit in a split
        integrations = { diffview = true },         -- adds integration with diffview.nvim
      })
    end,
  },
  {
    'olacin/telescope-gitmoji.nvim'
  },
  {
    'ruanyl/vim-gh-line',
    lazy = false
  }
}

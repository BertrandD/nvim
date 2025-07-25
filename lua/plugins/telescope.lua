return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
    opts = {
      defaults = {
        file_ignore_patterns = { "target" },
      },
      extensions = {
        gitmoji = {
          action = function(entry)
            local emoji = entry.value.value
            local pos = vim.api.nvim_win_get_cursor(0)[2]
            local line = vim.api.nvim_get_current_line()
            local nline = line:sub(0, pos) .. emoji .. line:sub(pos + 1)
            vim.api.nvim_set_current_line(nline)
          end,
        },
        frecency = {
          db_root = "/home/my_username/path/to/db_root",
          show_scores = true,
          show_unindexed = true,
          ignore_patterns = { "*.git/*", "*/tmp/*" },
          disable_devicons = false,
          workspaces = {},
        },
      },
    },
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "kkharji/sqlite.lua" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("neoclip").setup {
        enable_persistent_history = true,
      }
    end,
  },
}

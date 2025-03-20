local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = "all",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        line_numbers = true,
        mode = "topline",
        separator = "-",
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local conf = require "configs.dap"
      conf.setup()
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {},
  },
  {
    "djoshea/vim-autoread",
  },
  -- {
  --   'mg979/vim-visual-multi',
  --   lazy = false
  -- },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dap.repl.open()
      -- end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local merge_tb = vim.tbl_deep_extend
      local defaults = require "nvchad.configs.nvimtree"

      local opts = {
        sort_by = "case_sensitive",
        view = {
          width = 60,
        },
        git = {
          enable = true,
          ignore = false,
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            show = {
              git = true,
            },
          },
        },
        actions = {
          open_file = {
            resize_window = false,
          },
        },
        filters = {
          dotfiles = false,
        },
      }

      return merge_tb("force", defaults, opts)
    end,
  },
  -- {
  --  'rmagatti/auto-session',
  --   lazy = false,
  --   config = function()
  --     require("auto-session").setup {
  --       log_level = "error",
  --       auto_session_suppress_dirs = { "~/", "~/workspace", "~/Downloads", "/"},
  --     }
  --   end
  -- },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {
      -- auto_open = true, -- automatically open the list when you have diagnostics
      -- auto_close = true, -- automatically close the list when you have no diagnostics
      modes = {
        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item)
              return item.severity == severity
            end, items)
          end,
        },
      },
    },
  },
  {
    -- Not working yet !
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "aleixab/neotest-scala",
      "haydenmeade/neotest-jest",
      "mrcjkb/rustaceanvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-vim-test",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand "%")
        end,
        desc = "Run File",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.loop.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open { enter = true, auto_close = true }
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-python" {
            dap = { justMyCode = false },
          },
          require "neotest-scala" {
            runner = "sbt",
            framework = "scalatest",
          },
          require "rustaceanvim.neotest",
          require "neotest-jest",
          require "neotest-vim-test" {
            ignore_file_types = { "python", "vim", "lua", "rs", "rust", "scala", "ts", "typescript" },
          },
        },
        output_panel = {
          open = "botright vsplit | vertical resize 80",
        },
      }
    end,
  },
}
return plugins

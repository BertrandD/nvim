local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    dependencies = {
      'towolf/vim-helm'
    },
    opts = {
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "pyright",
        "typescript-language-server",
        -- "eslint",
        "clangd",
        "codelldb",
        "bash-language-server",
        "bash-debug-adapter"
      },
      PATH = "prepend"
    }
  },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = "all",
        },
    },
  {
    "mfussenegger/nvim-dap",
    config = function ()
        local bash = require('configs.bash-dap')
        bash.setup()
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap"
    },
    opts = {
    }
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function ()
      local configs = require("nvchad.configs.lspconfig")
      local on_attach = configs.on_attach

      vim.g.rustaceanvim = {
        dap = {
          autoload_configurations = true
        },
        server = {
          on_attach =  on_attach
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
  {
    "djoshea/vim-autoread"
  },
  -- {
  --   'mg979/vim-visual-multi',
  --   lazy = false
  -- },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()
      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dap.repl.open()
      -- end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = { "target" },
      },
      extensions = {
        gitmoji = {
          action = function (entry)
            local emoji = entry.value.value
            local pos = vim.api.nvim_win_get_cursor(0)[2]
            local line = vim.api.nvim_get_current_line()
            local nline = line:sub(0, pos) .. emoji .. line:sub(pos + 1)
            vim.api.nvim_set_current_line(nline)
          end
        }
      }
    }
  },
  {
    "scalameta/nvim-metals",
    -- lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      {
        "mfussenegger/nvim-dap",
        -- config = function(self, opts)
        --
        --   -- Debug settings if you're using nvim-dap
        --   local dap = require("dap")
        --
        --   dap.configurations.scala = {
        --     {
        --       type = "scala",
        --       request = "launch",
        --       name = "Run or test file",
        --       metals = {
        --         runType = "runOrTestFile",
        --       },
        --     }
        --   }
        -- end
      }
    }
  },
  {
    'kristijanhusak/vim-dadbod-ui',
     dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
     },
     cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
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
          ignore = false
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            show = {
              git = true
            }
          }
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
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    cmd = {
      "Neogit"
    },
    config = function()
      require("neogit").setup({
       kind = "vsplit", -- opens neogit in a split
       integrations = { diffview = true }, -- adds integration with diffview.nvim
      })
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
    'olacin/telescope-gitmoji.nvim'
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      auto_open = true, -- automatically open the list when you have diagnostics
      auto_close = true, -- automatically close the list when you have no diagnostics
    }
  },
  {
    -- Not working yet !
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "stevanmilic/neotest-scala",
      "haydenmeade/neotest-jest",
      "mrcjkb/rustaceanvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-vim-test"
    },
    keys = {
        { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
        { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
        { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
        { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-scala")({
            runner = "sbt",
            framework = "scalatest"
          }),
          require('rustaceanvim.neotest'),
          require("neotest-jest"),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua", "rs", "rust", "scala", "ts", "typescript" },
          }),
        },
      })
    end
  },
  {
    'ruanyl/vim-gh-line',
    lazy = false
  }
}
return plugins

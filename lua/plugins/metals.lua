return {
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
}

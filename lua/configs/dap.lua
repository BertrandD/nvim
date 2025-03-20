local M = {}
local install_root_dir = vim.fn.stdpath "data" .. "/mason"
local BASH_DEBUG_ADAPTER_BIN = install_root_dir .. "/bin/bash-debug-adapter"
local BASHDB_DIR = install_root_dir .. "/packages/bash-debug-adapter/extension/bashdb_dir"

function M.setup()
  local dap = require "dap"
  dap.adapters.sh = {
    type = "executable",
    command = BASH_DEBUG_ADAPTER_BIN,
  }
  dap.configurations.sh = {
    {
      name = "Launch Bash debugger",
      type = "sh",
      request = "launch",
      program = "${file}",
      cwd = "${fileDirname}",
      pathBashdb = BASHDB_DIR .. "/bashdb",
      pathBashdbLib = BASHDB_DIR,
      pathBash = "bash",
      pathCat = "cat",
      pathMkfifo = "mkfifo",
      pathPkill = "pkill",
      env = {},
      args = {},
      -- showDebugOutput = true,
      -- trace = true,
    },
  }

  -- Rust
  dap.adapters.codelldb = {
    type = "server",
    port = "9462",
    executable = {
      command = "/home/bertrand/.local/share/nvim/mason/bin/codelldb",
      args = { "--port", "9462" },
    },
  }
  -- dap.configurations.rust = {
  --   {
  --     name = "Launch",
  --     type = "codelldb",
  --     request = "launch",
  --     program = function()
  --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
  --     end,
  --     cwd = "${workspaceFolder}",
  --     stopOnEntry = false,
  --   },
  -- }
end

return M

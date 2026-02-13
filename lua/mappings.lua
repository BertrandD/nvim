require "nvchad.mappings"
local map = vim.keymap.set

-- Git mappings
map("n", "<C-k>", ":Neogit <CR>", { desc = "Git: Open Neogit" })
map("n", "<leader>gm", ":Telescope gitmoji <cr>", { desc = "Git: Insert emoji" })

-- Window navigation
map("n", "<C-Left>", "<C-w>h", { desc = "Window: Navigate left" })
map("n", "<C-Right>", "<C-w>l", { desc = "Window: Navigate right" })
map("n", "<C-Down>", "<C-w>j", { desc = "Window: Navigate down" })
map("n", "<C-Up>", "<C-w>k", { desc = "Window: Navigate up" })

-- Buffer operations
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Buffer: Close all except current" })

-- File operations
map("n", "<leader>jf", ":%!jq '.' <cr>", { desc = "File: Format JSON" })

-- Copilot mappings
map("n", "<C-l>", "<cmd> CopilotChat <CR>", { desc = "Copilot: Open chat" })
map("v", "<C-l>", "<cmd> CopilotChat <CR>", { desc = "Copilot: Open chat" })

-- LSP mappings
map("n", "<leader>sd", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "LSP: Document symbols" })

map("n", "<leader>sw", function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, { desc = "LSP: Workspace symbols" })

map("n", "<leader>ls", function()
  vim.lsp.buf.signature_help()
end, { desc = "LSP: Signature help" })

map("n", "<leader>lf", function()
  vim.diagnostic.open_float()
end, { desc = "LSP: Floating diagnostics" })

map("n", "<leader>d", "<cmd> RustLsp openDocs <CR>", { desc = "Rust: Open docs" })

-- Telescope mappings
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find: Buffers" })
map("n", "<leader>fr", "<cmd> Telescope lsp_references <CR>", { desc = "Find: References" })
map("n", "<leader>fi", "<cmd> Telescope lsp_implementations <CR>", { desc = "Find: Implementations" })
map("n", "<leader>fd", "<cmd> Telescope lsp_definitions <CR>", { desc = "Find: Definitions" })
map("n", "fr", "<cmd> Telescope lsp_references <CR>", { desc = "Find: References" })
map("n", "fi", "<cmd> Telescope lsp_implementations <CR>", { desc = "Find: Implementations" })
map("n", "fd", "<cmd> Telescope lsp_definitions <CR>", { desc = "Find: Definitions" })
map("n", "<leader>ftd", "<cmd> Telescope lsp_type_definitions <CR>", { desc = "Find: Type definitions" })
map("n", "<leader>fci", "<cmd> Telescope lsp_incoming_calls <CR>", { desc = "Find: Incoming calls" })
map("n", "<leader>fco", "<cmd> Telescope lsp_outgoing_calls <CR>", { desc = "Find: Outgoing calls" })
map("n", "<M-p>", "<cmd> Telescope neoclip <CR>", { desc = "Find: Clipboard history" })
map("n", "<M-r>", "<cmd> Telescope oldfiles <CR>", { desc = "Find: Recent files" })

map("n", "<leader>ftt", function()
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()
  require("telescope.builtin").live_grep { search_dirs = { node.absolute_path } }
end, { desc = "Find: In tree selection" })

map("n", "<leader>lmc", function()
  require("telescope").extensions.metals.commands()
end, { desc = "Metals: Commands" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code actions" })

-- Trouble mappings
map("n", "<leader>tw", "<cmd>Trouble cascade toggle<cr>", { desc = "Trouble: Diagnostics" })
map("n", "<leader>tb", "<cmd>Trouble cascade toggle filter.buf=0<cr>", { desc = "Trouble: Buffer diagnostics" })
map("n", "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "Trouble: LSP symbols" })
map("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble: Location list" })
map("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble: Quickfix list" })

-- DAP (Debug Adapter Protocol) mappings
map("n", "<F2>", ":DapTerminate<CR>", { desc = "Debug: Terminate" })
map("n", "<F4>", ":lua require('dapui').toggle()<CR>", { desc = "Debug: Toggle UI" })
map("n", "<F5>", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Debug: Toggle breakpoint" })
map("n", "<F8>", ":lua require('dap').run_last()<CR>", { desc = "Debug: Run last" })

map("n", "<F9>", function()
  -- (Re-)reads launch.json if present
  if vim.fn.filereadable ".vscode/launch.json" then
    require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
  end
  require("dap").continue()
end, { desc = "Debug: Start/Continue" })

map("n", "<F10>", ":lua require('dap').step_over()<CR>", { desc = "Debug: Step over" })
map("n", "<F11>", ":lua require('dap').step_into()<CR>", { desc = "Debug: Step into" })
map("n", "<F12>", ":lua require('dap').step_out()<CR>", { desc = "Debug: Step out" })
map("n", "<leader>dr", ":lua require('dap').repl.open()<CR>", { desc = "Debug: Open REPL" })
map("n", "<leader>dc", ":lua require('dap').console.open()<CR>", { desc = "Debug: Open console" })

map("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Debug: Hover" })

map("n", "<leader>df", function()
  local widgets = require "dap.ui.widgets"
  widgets.centered_float(widgets.frames)
end, { desc = "Debug: Frames" })

map("n", "<leader>ds", function()
  local widgets = require "dap.ui.widgets"
  widgets.centered_float(widgets.scopes)
end, { desc = "Debug: Scopes" })

-- Gitsigns mappings
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { desc = "Git: Next hunk", expr = true })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { desc = "Git: Previous hunk", expr = true })

map("n", "<leader>rh", function()
  require("gitsigns").reset_hunk()
end, { desc = "Git: Reset hunk" })

map("n", "<leader>ph", function()
  require("gitsigns").preview_hunk()
end, { desc = "Git: Preview hunk" })

map("n", "<leader>gb", function()
  package.loaded.gitsigns.blame_line()
end, { desc = "Git: Blame line" })

map("n", "<leader>td", function()
  require("gitsigns").toggle_deleted()
end, { desc = "Git: Toggle deleted" })

-- Spectre mappings
map("n", "<leader>S", function()
  require("spectre").toggle()
end, { desc = "Search: Toggle Spectre" })

map("n", "<leader>Sw", function()
  require("spectre").open_visual { select_word = true }
end, { desc = "Search: Current word" })

map("n", "<leader>Sp", function()
  require("spectre").open_file_search { select_word = true }
end, { desc = "Search: In current file" })

map("v", "<leader>Sw", function()
  require("spectre").open_visual()
end, { desc = "Search: Current word" })

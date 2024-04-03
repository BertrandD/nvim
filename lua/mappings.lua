require "nvchad.mappings"
local M = {}

M.git = {
  n = {
    ["<C-k>"] = {":Neogit <CR>", "Open Neogit"},
    ["<leader>gm"] = { ":Telescope gitmoji <cr>", "Insert gitmoji"},
  }
}

M.tests = {
  n = {
    ["<leader>Tt"] = {
      function()
        require("neotest").run.run()
      end
      , "Run nearest test"}
  }
}

M.general = {
  n = {
    ["<C-Left>"] = { "<C-w>h", "Window left" },
    ["<C-Right>"] = { "<C-w>l", "Window right" },
    ["<C-Down>"] = { "<C-w>j", "Window down" },
    ["<C-Up>"] = { "<C-w>k", "Window up" },
    ["<leader>jf"] = {":%!jq '.' <cr>", "Format json file"}
  }
}

M.lspconfig = {
  n = {
    ["<leader>sd"] = { function()
      require("telescope.builtin").lsp_document_symbols()
    end, "LSP Document Symbols"},
    ["<leader>sw"] = { function()
      require("telescope.builtin").lsp_dynamic_workspace_symbols()
    end, "LSP Workspace Symbols"}
  }
}

M.telescope = {
  n = {
    ["<leader>fb"] = { "<cmd> Telescope buffers sort_lastused=true <CR>", "Find buffers" },
    ["<leader>fd"] = { function()
      local api = require("nvim-tree.api")
      local node = api.tree.get_node_under_cursor()
      require('telescope.builtin').live_grep({search_dirs={node.absolute_path}})

    end, "Find in selected directory"},
    ["<leader>lmc"] = { function ()
      require("telescope").extensions.metals.commands()
    end, "Metals commands"}
  }
}

M.trouble = {
  n = {
    ["<leader>ll"] = { function() require("trouble").toggle() end, "Open Trouble"},
    ["<leader>lw"] = { function() require("trouble").toggle("workspace_diagnostics") end, "Open Workspace diagnostics"},
    ["<leader>ld"] = { function() require("trouble").toggle("document_diagnostics") end, "Open Document diagnostics"},
    ["<leader>lq"] = { function() require("trouble").toggle("quickfix") end, "Quickfix"},
  }
}

M.dap = {
  n = {
    ["<F2>"] = {":DapTerminate<CR>", "Open DapUi"},
    ["<F4>"] = {":lua require('dapui').toggle()<CR>", "Open DapUi"},
    ["<F5>"] = {":lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint"},
    ["<F8>"] = {":lua require('dap').run_last()<CR>", "Run last"},
    ["<F9>"] = {
      function()
            -- (Re-)reads launch.json if present
            if vim.fn.filereadable(".vscode/launch.json") then
                require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } }) -- , codelldb = {"rust"}
            end
            require("dap").continue()
        end,
      "Start or continue debugger"
    },
    ["<F10>"] = {":lua require('dap').step_over()<CR>", "Stop over"},
    ["<F11>"] = {":lua require('dap').step_into()<CR>", "Stop into"},
    ["<F12>"] = {":lua require('dap').step_out()<CR>", "Stop out"},
    ["<leader>dr"] = {":lua require('dap').repl.open()<CR>", "Open repl"},
    ["<leader>dc"] = {":lua require('dap').console.open()<CR>", "Open Run console"},
    ["<leader>dh"] = {function() require('dap.ui.widgets').hover() end, "Hover"},
    ["<leader>df"] = {function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, "Frames"},
    ["<leader>ds"] = {function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end, "Scopes"},


  }
}

local map = vim.keymap.set

for group, mappings in pairs(M) do
    for mode, maps in pairs(mappings) do
      for key, val in pairs(maps) do
        map(mode, key, val[1], { desc = val[2] })
      end
    end
end

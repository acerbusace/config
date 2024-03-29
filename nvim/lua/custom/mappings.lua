local M = {}

M.CopilotChat = {
  plugin = true,

  n = {
    ["<leader>cb"] = { ":CopilotChatBuffer ", "CopilotChat - Chat with current buffer" },
    ["<leader>ce"] = { "<cmd>CopilotChatExplain<cr>", "CopilotChat - Explain code" },
    ["<leader>ct"] = { "<cmd>CopilotChatTests<cr>", "CopilotChat - Generate tests" },
    ["<leader>cT"] = { "<cmd>CopilotChatVsplitToggle<cr>", "CopilotChat - Toggle Vsplit" },
    ["<leader>cf"] = { "<cmd>CopilotChatFixDiagnostic<cr>", "CopilotChat - Fix diagnostic" },
    ["<leader>cr"] = { "<cmd>CopilotChatReset<cr>", "CopilotChat - Reset chat history and clear buffer" },
    ["<leader>cq"] = {
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          vim.cmd("CopilotChatBuffer " .. input)
        end
      end,
      "CopilotChat - Quick chat"
    },
     -- Show help actions with telescope
    ["<leader>cH"] = {
      function()
        require("CopilotChat.code_actions").show_help_actions()
      end,
      "CopilotChat - Help actions"
    },
    -- Show prompts actions with telescope
    ["<leader>cp"] = {
      function()
        require("CopilotChat.code_actions").show_prompt_actions()
      end,
      "CopilotChat - Help actions"
    },
  },

  v = {
    ["<leader>cv"] = { ":CopilotChatVisual ", "CopilotChat - Open in vertical split" },
    ["<leader>cx"] = { ":CopilotChatInPlace<cr>", "CopilotChat - Run in-place code" },
    ["<leader>cp"] = { ":lua require('CopilotChat.code_actions').show_prompt_actions(true)<CR>", "CopilotChat - Prompt actions" }
  },
}

M.dap = {
  plugin = true,

  n = {
    ["<leader>tb"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "DAP - Toggle Breakpoint"
    },
    ["<leader>tc"] = {
      function()
        require("dap").continue()
      end,
      "DAP - Continue Debugging"
    },
    ["<leader>t["] = {
      function()
        require("dap").step_over()
      end,
      "DAP - Step Over"
    },
    ["<leader>t]"] = {
      function()
        require("dap").setup_into()
      end,
      "DAP - Step Into"
    },
    ["<leader>ti"] = {
      function()
        require("dap").repl.open()
      end,
      "DAP - Inspector State"
    },
  },
}

M.dapui = {
  plugin = true,

  n = {
    ["<leader>tu"] = {
      function()
        require("dapui").toggle()
      end,
      "DAP UI - Toggle Windows"
    },
  },
}

M.neotest = {
  plugin = true,

  n = {
    ["<leader>tf"] = {
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      "Run File"
    },
    ["<leader>tF"] = {
      function()
        require("neotest").run.run(vim.loop.cwd())
      end,
      "Run All Test Files"
    },
    ["<leader>tr"] = {
      function()
        require("neotest").run.run()
      end,
      "Run Nearest"
    },
    ["<leader>tR"] = {
      function()
        require("neotest").run.run({strategy = "dap"})
      end,
      "Debug Nearest"
    },
    ["<leader>ts"] = {
      function()
        require("neotest").summary.toggle()
      end,
      "Toggle Summary"
    },
    ["<leader>to"] = {
      function()
        require("neotest").output.open()
      end,
      "Show Output"
    },
    ["<leader>tO"] = {
      function()
        require("neotest").output_panel.toggle()
      end,
      "Toggle Output Panel"
    },
    ["<leader>tS"] = {
      function()
        require("neotest").run.stop()
      end,
      "Stop"
    },
  },
}

return M

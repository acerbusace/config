local M = {}

M.CopilotChat = {
  plugin = true,

  n = {
    ["<leader>ce"] = { "<cmd>CopilotChatExplain<cr>", "CopilotChat - Explain code" },
    ["<leader>ct"] = { "<cmd>CopilotChatTests<cr>", "CopilotChat - Generate tests" },
    ["<leader>cr"] = { "<cmd>CopilotChatReview<cr>", "CopilotChat - Review code" },
    ["<leader>cR"] = { "<cmd>CopilotChatRefactor<cr>", "CopilotChat - Refactor code" },
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

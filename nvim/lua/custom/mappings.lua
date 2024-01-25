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

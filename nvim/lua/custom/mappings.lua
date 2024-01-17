local M = {}

M.neotest = {
  plugin = true,

  n = {
    ["<leader>tt"] = {
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      "Run File"
    },
    ["<leader>tT"] = {
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
    -- ["<Leader>tr"] = {':lua require("neotest").run.run()<CR>', "Neotest run", opts = { noremap = true, silent = true }},
    -- ["<Leader>ts"] = {':lua require("neotest").run.stop()<CR>', "Neotest stop", opts = { noremap = true, silent = true }},
    -- ["<Leader>to"] = {':lua require("neotest").output.open()<CR>', "Neotest output", opts = { noremap = true, silent = true }},
    -- ["<Leader>tO"] = {':lua require("neotest").output.open({ enter = true })<CR>', "Neotest output detailed", opts = { noremap = true, silent = true }},
    -- ["<Leader>ti"] = {':lua require("neotest").summary.toggle()<CR>', "Neotest summary", opts = { noremap = true, silent = true }},
    -- ["<Leader>tf"] = {':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "Neotest run all tests in file", opts = { noremap = true, silent = true }},
    -- ["[n"] = {'<cmd>lua require("neotest").jump.prev({ status = "failed" })', "Neotest next", opts = { silent = true }},
    -- ["]n"] = {'<cmd>lua require("neotest").jump.next({ status = "failed" })', "Neotest previous", opts = { silent = true }},
  },
}

return M

local overrides = require("custom.configs.overrides")
local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",

       -- high level
        "ruby",
        "rbs"
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local conf = require "plugins.configs.cmp"
      table.insert(conf.sources, { name = "copilot" })
      return conf
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require "custom.configs.neodev"
    end,
  },
  {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "lua-language-server",
        "standardrb",
        "solargraph"
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- Lazy load when event occurs. Events are triggered
    -- as mentioned in:
    -- https://vi.stackexchange.com/a/4495/20389
    event = "InsertEnter",
    -- You can also have it load at immediately at
    -- startup by commenting above and uncommenting below:
    lazy = false,
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
    opts = overrides.copilot,
    keys = {
      { "<leader>pa", function() require("copilot.suggestion").accept_line() end, desc = "Accept line" },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "vim-test/vim-test",
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require "custom.configs.neotest"
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open() end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  }
}
return plugins

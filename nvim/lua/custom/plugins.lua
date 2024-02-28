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
    lazy = false,
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
      language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
      prompts = {
        Explain = "Explain how it works.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity and readability.",
      },
    },
    build = function()
      vim.notify("CopilotChat - Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>cb", ":CopilotChatBuffer ", desc = "CopilotChat - Chat with current buffer" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      {
        "<leader>cT",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>cv",
        ":CopilotChatVisual ",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>cx",
        ":CopilotChatInPlace<cr>",
        mode = "x",
        desc = "CopilotChat - Run in-place code",
      },
      {
        "<leader>cf",
        "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
        desc = "CopilotChat - Fix diagnostic",
      },
      {
        "<leader>cr",
        "<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
        desc = "CopilotChat - Reset chat history and clear buffer",
      }
    },
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
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "NeoTest - Run File" },
      { "<leader>tF", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "NeoTest - Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "NeoTest - Run Nearest" },
      { "<leader>tR", function() require("neotest").run.run({strategy = "dap"}) end, desc = "NeoTest - Debug Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "NeoTest - Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open() end, desc = "NeoTest - Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "NeoTest - Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "NeoTest - Stop" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "suketa/nvim-dap-ruby",
    },
    keys = {
      { "<leader>tb", function() require("dap").toggle_breakpoint() end, desc = "DAP - Toggle Breakpoint" },
      { "<leader>tc", function() require("dap").continue() end, desc = "DAP - Continue Debugging" },
      { "<leader>t[", function() require("dap").step_over() end, desc = "DAP - Step Over" },
      { "<leader>t]", function() require("dap").step_into() end, desc = "DAP - Step Into" },
      { "<leader>ti", function() require("dap").repl.open() end, desc = "DAP - Inspect State" },
    },
  },
  {
    "suketa/nvim-dap-ruby",
    config = function ()
      require("dap-ruby").setup()
    end
  }
}

return plugins

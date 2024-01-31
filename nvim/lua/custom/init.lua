vim.o.scrolloff = 8 -- start scrolling when we're 8 lines away from margins

-- Enable python3 provier. Used for CopilotChat plugin.
local enable_providers = {
  "python3_provider",
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

-- Loads :UpdateRemotePlugins command
vim.cmd("runtime plugin/rplugin.vim")

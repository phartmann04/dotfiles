local dap = require("dap")

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"

local netcoredbg_adapter = {
  type = "executable",
  command = mason_path,
  args = { "--interpreter=vscode" },
}

dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
dap.adapters.coreclr = netcoredbg_adapter    -- needed for unit test debugging

local function pick_telesto_pid()
  local lines = vim.fn.systemlist(
    "ps aux | grep Telesto.WebApi | grep -v grep | awk '{print $2}' | head -n 1"
  )
  -- systemlist returns a table; take the first line
  local pid_str = lines[1]
  if not pid_str or pid_str == "" then
    error("No Telesto.WebApi process found. Is `dotnet run` running?")
  end
  local pid = tonumber(pid_str)
  if not pid then
    error("Failed to parse PID from: " .. pid_str)
  end
  return pid
end

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "attach to Telesto",
    request = "attach",
    processId = pick_telesto_pid,
  },
}


local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
map("n", "<F6>", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", opts)
map("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
map("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
map("n", "<F8>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
map("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
map("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
map("n", "<leader>dt", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
  { noremap = true, silent = true, desc = 'debug nearest test' })

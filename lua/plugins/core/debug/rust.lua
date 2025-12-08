-- Function to load environment variables from export statements in a script
local function load_exports_from_script(script_path)
  local env = {}
  local file = io.open(script_path, "r")
  if not file then
    vim.notify("Could not open " .. script_path, vim.log.levels.WARN)
    return env
  end

  for line in file:lines() do
    -- Match lines like: export VAR=value or export VAR="value"
    local key, value = line:match("^%s*export%s+([%w_]+)%s*=%s*(.+)$")
    if key and value then
      -- Remove quotes if present
      value = value:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
      -- Remove inline comments
      value = value:gsub("%s*#.*$", "")
      env[key] = value
    end
  end

  file:close()
  return env
end

-- Helper to create a wrapper script with I/O redirection
local function create_wrapper_script(program, args_table)
  local wrapper_path = "/tmp/nvim_dap_wrapper.sh"
  local args_str = table.concat(args_table or {}, " ")

  local script_content = string.format([[#!/bin/bash
%s %s > /tmp/nvim_dap_output.log 2>&1
]], program, args_str)

  local file = io.open(wrapper_path, "w")
  if file then
    file:write(script_content)
    file:close()
    os.execute("chmod +x " .. wrapper_path)
  end

  return wrapper_path
end

-- Cache for last used inputs (shared across all configs)
local last_run = {
  program = nil,
  args = {},
  env = {},
}

return {
  {
    name = "Run with args",
    type = "codelldb",
    request = "launch",
    program = function()
      last_run.program = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      return last_run.program
    end,
    args = function()
      local args = {}

      -- Prompt for port (always included)
      local port = vim.fn.input("Port: ", "8080")
      if port ~= "" then
        table.insert(args, "--port")
        table.insert(args, port)
      end

      -- Prompt for additional args (optional)
      local additional_args = vim.fn.input("Additional args (space-separated): ")
      if additional_args ~= "" then
        -- Split by spaces and add each arg
        for arg in string.gmatch(additional_args, "%S+") do
          table.insert(args, arg)
        end
      end

      -- Cache for re-run
      last_run.args = args

      return args
    end,
    env = function()
      local env_script = vim.fn.input("Path to env script (leave empty to skip): ", vim.fn.getcwd() .. "/env.sh", "file")
      if env_script ~= "" then
        last_run.env = load_exports_from_script(env_script)
      else
        last_run.env = {}
      end
      return last_run.env
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    initCommands = {
      "log enable lldb process -f /tmp/lldb_process.log",
      "log enable lldb stdio -f /tmp/lldb_stdio.log",
    },
  },
  -- Add more configurations here as separate table entries
  -- Example:
  {
    name = "Run",
    type = "codelldb",
    request = "launch",
    program = "${workspaceFolder}/target/debug/your_binary",
    args = { "--port", "8080" },
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    initCommands = {
      "log enable lldb process -f /tmp/lldb_process.log",
      "log enable lldb stdio -f /tmp/lldb_stdio.log",
    },
  },

  {
    name = "Market Data",
    type = "codelldb",
    request = "launch",
    program = function()
      last_run.program = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      return last_run.program
    end,
    args = function()
      local args = {}

      -- Prompt for port (always included)
      local port = vim.fn.input("Port: ", "8080")
      if port ~= "" then
        table.insert(args, "--port")
        table.insert(args, port)
      end

      -- Prompt for additional args (optional)
      local additional_args = vim.fn.input("Additional args (space-separated): ")
      if additional_args ~= "" then
        -- Split by spaces and add each arg
        for arg in string.gmatch(additional_args, "%S+") do
          table.insert(args, arg)
        end
      end

      -- Cache for re-run
      last_run.args = args

      return args
    end,
    env = function()
      local env_script = vim.fn.input("Path to env script (leave empty to skip): ", vim.fn.getcwd() .. "/env.sh", "file")
      if env_script ~= "" then
        last_run.env = load_exports_from_script(env_script)
      else
        last_run.env = {}
      end
      return last_run.env
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    initCommands = {
      "log enable lldb process -f /tmp/lldb_process.log",
      "log enable lldb stdio -f /tmp/lldb_stdio.log",
    },
  },
  {
    name = "Re-run last",
    type = "codelldb",
    request = "launch",
    program = function()
      if not last_run.program then
        vim.notify("No previous run found. Use another config first.", vim.log.levels.WARN)
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end
      return last_run.program
    end,
    args = function()
      return last_run.args
    end,
    env = function()
      return last_run.env
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    initCommands = {
      "log enable lldb process -f /tmp/lldb_process.log",
      "log enable lldb stdio -f /tmp/lldb_stdio.log",
    },
  },
}

return {
  "mfussenegger/nvim-dap",
  dependencies = {
	"nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
	
	dapui.setup()

	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = "/home/akramhany/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",  -- Change this!
			args = { "--port", "${port}" },
		}
	}

	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "codelldb",  -- Use codelldb here
			request = "launch",
			program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/a.out", "file")
			end,
			args = function()
			local args_str = vim.fn.input("Arguments: ")
			return vim.split(args_str, " ")
			end,
            --runInTerminal = false,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
	}

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
	vim.keymap.set("n", "<F2>", dap.step_into)
	vim.keymap.set("n", "<F3>", dap.step_over)
	vim.keymap.set("n", "<F4>", dap.step_out)
	vim.keymap.set("n", "<F5>", dap.step_back)
	-- vim.keymap.set("n", "<Leader>dw", dap., { desc = "Watch a variable in dap-ui" })
	
	vim.keymap.set("n", "<Leader>dw", function() require("dapui").elements.watches.add() end)
	vim.keymap.set("n", "<Leader>dr", function() require("dap").repl.open() end)
  end,
}

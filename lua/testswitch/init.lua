local M = {} -- M stands for module, a naming convention

function TestFileSwitch()
	local buf_name = vim.api.nvim_buf_get_name(0)
	if string.match(buf_name, ".*[.]go") then
		local new_buf_name, _ = string.gsub(buf_name, "[.]go", "_test.go")
		if vim.fn.filereadable(new_buf_name) == 1 then
			vim.api.nvim_command("e " .. new_buf_name)
		end
	end
	if string.match(buf_name, ".*_test.go") then
		local new_buf_name, _ = string.gsub(buf_name, "_test[.]go", ".go")
		if vim.fn.filereadable(new_buf_name) == 1 then
			vim.api.nvim_command("e " .. new_buf_name)
		end
	end
end

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_create_user_command("TestFileSwitch", TestFileSwitch, {})
	vim.keymap.set("n", "<Leader>t", TestFileSwitch)
end

return M

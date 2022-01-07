local M ={}

function M:OpenWithProgram()

    if vim.g.OpenWithPrograms then
        local file = vim.api.nvim_buf_get_name(0)
        local filetype = vim.api.nvim_exec('echo &filetype', true)
        -- open file with program asynchronously
        for k,program in pairs(vim.g.OpenWithPrograms) do
            if k == filetype then
                handle = vim.loop.spawn(program, {
                    args = {file}
                }, function() handle:close() end )
                break
            end
        end
    end
end

return M

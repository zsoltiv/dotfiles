local M ={}

function M:OpenWith(program)
    local file = vim.api.nvim_buf_get_name(0)
    -- open file with program asynchronously
    handle = vim.loop.spawn(program, {
        args = {file}
    }, function() handle:close() end )
end

return M

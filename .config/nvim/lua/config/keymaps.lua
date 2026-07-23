-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- Exit insert mode with jk
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Copy to system clipboard with Cmd+C (without affecting yank register)
map("v", "<D-c>", function()
    local saved_reg = vim.fn.getreg('"')
    local saved_regtype = vim.fn.getregtype('"')
    vim.cmd('silent normal! "+ygv')
    vim.fn.setreg('"', saved_reg, saved_regtype)
end, { desc = "Copy to system clipboard" })

-- Exit terminal mode with double Escape
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

return {
  {
    "LazyVim/LazyVim",
    init = function()
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "FocusLost" }, {
        pattern = "*",
        callback = function()
          if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent update")
          end
        end,
      })
    end,
  },
}

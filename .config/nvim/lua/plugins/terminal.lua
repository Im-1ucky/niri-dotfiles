return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>ft",
      function()
        local dir = vim.fn.expand("%:p:h")
        Snacks.terminal(nil, {
          cwd = dir,
        })
      end,
      desc = "Terminal (File Dir)",
    },
  },
}

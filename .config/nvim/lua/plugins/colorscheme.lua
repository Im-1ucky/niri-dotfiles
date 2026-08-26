return {
  {
    "catppuccin/nvim",
    priority = 1000,
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local theme_file = vim.fn.expand("~/.config/theme/current-nvim-theme")

      local file = io.open(theme_file, "r")

      if file then
        local theme = file:read("*l")
        file:close()

        if theme and theme ~= "" then
          opts.colorscheme = theme
        end
      end
    end,
  },
}

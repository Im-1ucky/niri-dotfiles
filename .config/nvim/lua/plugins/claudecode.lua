return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      terminal_cmd = "zsh -ic code",

      terminal = {
        cwd_provider = function(ctx)
          return require("claudecode.cwd").git_root(ctx.file_dir or ctx.cwd) or ctx.file_dir or ctx.cwd
        end,
      },
    },

    keys = {
      {
        "<leader>cd",
        "<cmd>ClaudeCode<cr>",
        desc = "Claude Code",
      },
    },
  },
}

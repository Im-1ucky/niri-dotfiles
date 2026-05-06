return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Web Dev (React + Node.js)
        tsserver = {},

        -- Python (Data Engineering)
        pyright = {},

        -- SQL (PostgreSQL)
        sqls = {},

        -- DevOps / Infra
        bashls = {},
        yamlls = {},
        jsonls = {},

        -- Terraform (later phase)
        terraformls = {},
      },
    },
  },
}

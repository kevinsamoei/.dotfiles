---@diagnostic disable: undefined-global

-- Setup function for attaching LSP
local simon_on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gv", "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)

  buf_set_keymap("n", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<C-a>", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", opts)
  buf_set_keymap("v", "<C-a>", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", opts)
  buf_set_keymap("n", "gR", "<cmd>lua require('fzf-lua').lsp_finder()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

  buf_set_keymap("n", "gt", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
  buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

  buf_set_keymap("n", "go", "<cmd>lua require('fzf-lua').lsp_outgoing_calls()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua require('fzf-lua').lsp_incoming_calls()<CR>", opts)

  buf_set_keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  buf_set_keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  buf_set_keymap("n", "[E", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]E", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  buf_set_keymap("n", ",e", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>", opts)
  buf_set_keymap("n", ",E", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<space>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gl", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", opts)
  buf_set_keymap("n", "gL", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>", opts)

  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

  if client.supports_method("textDocument/formatting") then
    local excluded_filetypes = {
      yaml = true,
      json = true,
      markdown = true,
      python = true,
    }

    local filetype = vim.bo.filetype
    if not excluded_filetypes[filetype] then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end

  vim.diagnostic.config({ virtual_text = false, float = { enabled = true } })

  buf_set_keymap("n", ",f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  buf_set_keymap("v", ",f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
end

-- Initialize lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "rust",
          "python",
          "ruby",
          "proto",
          "perl",
          "vim",
          "php",
          "go",
          "c",
          "cpp",
          "sql",
          "javascript",
          "typescript",
          "terraform",
          "json",
          "cuda",
          "asm",
          "dockerfile",
          "toml",
          "yaml",
          "bash",
          "html",
          "css",
          "scss",
          "tsx",
          "zig",
        },
        ignore_install = { "phpdoc", "markdown" },
        sync_install = false,
        matchup = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = { "markdown" },
        },
        endwise = {
          enable = true,
        },
        indent = {
          enable = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aa"] = "@call.outer",
              ["ia"] = "@call.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = "@scope",
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            goto_next = {
              ["]d"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            },
          },
        },
      })
    end,
  },
  {
    "junegunn/seoul256.vim",
    config = function()
      vim.cmd([[
      let g:seoul256_background = 236
      let g:seoul256_srgb = 1
      colorscheme seoul256
      set background=dark
    ]])
    end,
  },
  -- Add the rest of your plugins here...
  -- The full plugin list has been truncated for brevity
})

-- LSP setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.g.lsp_capabilities = capabilities

-- Setup diagnostic config
vim.o.updatetime = 250
vim.cmd([[
  augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false, relative = 'cursorHold' })
  augroup END
]])

-- Mason and LSP configuration
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = simon_on_attach,
      capabilities = vim.g.lsp_capabilities,
      settings = server_name == "lua_ls" and {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
          },
        },
      } or {},
    })
  end,

  ["sorbet"] = function()
    require("lspconfig").sorbet.setup({
      on_attach = simon_on_attach,
      capabilities = vim.g.lsp_capabilities,
      cmd = {
        "srb",
        "tc",
        "--typed",
        "true",
        "--enable-all-experimental-lsp-features",
        "--lsp",
        "--disable-watchman",
        "--suppress-error-code",
        "7003",
        "--typed-override",
        "sorbet/typed_overrides.yml",
      },
      ruby = {
        suggest = true,
        diagnostics = true,
      },
    })
  end,
})

-- null-ls setup
local null_ls = require("null-ls")
local methods = require("null-ls.methods")
null_ls.setup({
  on_attach = simon_on_attach,
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.mypy.with({
      command = "/Users/simon/.asdf/shims/mypy",
      method = methods.internal.DIAGNOSTICS_ON_SAVE,
    }),
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" },
    }),
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.code_actions.refactoring,
  },
})

-- fzf-lua setup
local actions = require("fzf-lua.actions")
local fzf = require("fzf-lua")
fzf.register_ui_select()
fzf.setup({
  -- Your fzf configuration here...
})

-- nvim-tree setup
require("nvim-tree").setup({
  settings = {
    view = {
      width = 30,
    },
  },
})

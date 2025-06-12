---@diagnostic disable: undefined-global
vim.g.mapleader = ","

vim.api.nvim_set_keymap("n", "<leader>d", ":bd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "\\d", ':put =strftime("# %Y-%m-%d")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "\\D", ':put =strftime("%Y-%m-%d")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("n", "L", ":set invnumber<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "cf", ':let @* = expand("%:t")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "cF", ':let @* = expand("%:p")<CR>', { noremap = true, silent = true })

vim.opt.termguicolors = false
vim.opt.filetype = "off"
vim.opt.iskeyword:append("-")
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.wildignore:append({
  ".git/**",
  "public/assets/**",
  "log/**",
  "tmp/**",
  "Cellar/**",
  "app/assets/images/**",
  "_site/**",
  "home/.vim/bundle/**",
  "pkg/**",
  "**/.gitkeep",
  "**/.DS_Store",
  "**/*.netrw*",
  "node_modules/*",
})
-- vim.opt.t_Co = "256"
vim.opt.textwidth = 80
-- vim.opt.scrolloff = 5
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = ""
vim.opt.errorbells = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.hidden = true
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.diffopt:append({ "filler", "vertical" })

if vim.fn.has("nvim") == 1 then
  vim.opt.inccommand = "split"

  vim.opt.statusline = "%4* %<%f%* %1*%= %5l%* %2*/%L%*"

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  Simon_on_attach = function(client, bufnr)
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

    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts) -- No default in Neovim 0.10
    buf_set_keymap("n", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<C-a>", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", opts)
    buf_set_keymap("v", "<C-a>", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", opts)
    buf_set_keymap("n", "gR", "<cmd>lua require('fzf-lua').lsp_finder()<CR>", opts)
    -- buf_set_keymap('n', 'gr', "<cmd>lua require(\'fzf-lua\').lsp_references()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

    buf_set_keymap("n", "gt", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
    buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

    buf_set_keymap("n", "go", "<cmd>lua require('fzf-lua').lsp_outgoing_calls()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua require('fzf-lua').lsp_incoming_calls()<CR>", opts)

    -- Default in Neovim 0.10 is [d, ]d, so maybe should stop using these!
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

    -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable=false})]]
    -- Should be the same as this?
    vim.diagnostic.config({ virtual_text = false, float = { enabled = true } })

    buf_set_keymap("n", ",f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    buf_set_keymap("v", ",f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  end

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
            -- "markdown",
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

              -- Automatically jump forward to textobj, similar to targets.vim
              lookahead = true,
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",

                ["aa"] = "@call.outer",
                ["ia"] = "@call.inner",

                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                ["as"] = "@scope",
              },
              selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V",  -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
              },
              include_surrounding_whitespace = false,
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
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
    -- { 'RRethy/nvim-base16', commit = '3c6a56016cea7b892f1d5b9b5b4388c0f71985be', config = function()
    --  vim.cmd [[
    --     let base16colorspace=256
    --     colorscheme base16-default-dark
    --     hi LineNr guifg=#5c6370
    --     " Light
    --     " https://github.com/RRethy/nvim-base16
    --     " colorscheme base16-gruvbox-material-light-hard
    --  ]]
    -- end },
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
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        vim.cmd([[ let g:copilot_enabled = v:false ]])
      end,
    },
    {
      "github/copilot.vim",
      config = function()
        require("supermaven-nvim").setup({})
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup({
          opts = {
            enable_close = true,           -- Auto close tags
            enable_rename = true,          -- Auto rename pairs of tags
            enable_close_on_slash = false, -- Auto close on trailing </
          },
          per_filetype = {
            -- ["html"] = {
            --   enable_close = false
            -- }
          },
        })
      end,
    },
    "RRethy/nvim-treesitter-endwise",
    {
      "nvim-treesitter/nvim-treesitter-textobjects", -- if / af for selection body
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    "sindrets/diffview.nvim",
    {
      "lewis6991/gitsigns.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local gs = require("gitsigns")
        gs.setup({
          signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "-" },
            update = { text = "U" },
            untracked = { text = "?" },
          },
          current_line_blame = false,
          current_line_blame_opts = {
            delay = 2000,
          },
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            if vim.g.gitgutter_diff_base then
              -- defer to ensure it happens after setup, I think this variable when set with -C might be set after the plugin has loaded
              vim.defer_fn(function()
                gs.change_base(vim.g.gitgutter_diff_base, true)
              end, 100)
            end

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]h", function()
              if vim.wo.diff then
                return "]h"
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return "<Ignore>"
            end, { expr = true })

            map("n", "[h", function()
              if vim.wo.diff then
                return "[h"
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return "<Ignore>"
            end, { expr = true })

            -- Our own
            map("n", "<leader>hm", function()
              gs.change_base("master", true)
            end)
            map("n", "<leader>hc", function()
              vim.ui.input({ prompt = "Change Git Base To: ", default = vim.g.gitgutter_diff_base }, function(input)
                gs.change_base(input, true)
              end, true)
            end)

            -- -- Actions
            map("n", "<leader>hs", gs.stage_hunk)
            map("n", "<leader>hr", gs.reset_hunk)
            map("v", "<leader>hs", function()
              gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end)
            map("v", "<leader>hr", function()
              gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end)
            map("n", "<leader>hS", gs.stage_buffer)
            map("n", "<leader>hu", gs.undo_stage_hunk)
            map("n", "<leader>hR", gs.reset_buffer)
            map("n", "<leader>hp", gs.preview_hunk)
            map("n", "<leader>hB", function()
              gs.blame_line({ full = true })
            end)
            map("n", "<leader>hb", gs.toggle_current_line_blame)
            map("n", "<leader>hd", gs.diffthis)
            map("n", "<leader>hD", function()
              gs.diffthis("~")
            end)
            map("n", "<leader>he", gs.toggle_deleted)
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            map("n", "<leader>hq", function()
              gs.setqflist("all")
            end)
            map("n", "<leader>hl", function()
              gs.setloclist(0)
            end)
          end,
        })
      end,
    },
    "tpope/vim-fugitive",
    -- Lsp --
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    {
      "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif vim.fn["vsnip#available"](1) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "vsnip" },
            -- { name = 'buffer' },
            { name = "path" },
          }),
          -- Formatting of completion menu
          formatting = {
            format = function(entry, vim_item)
              -- Source
              vim_item.menu = ({
                -- buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                vsnip = "[Snippet]",
                path = "[Path]",
              })[entry.source.name]
              return vim_item
            end,
          },
          -- Experimental features
          experimental = {
            ghost_text = true,
          },
        })

        local function toggle_autocomplete()
          local current_setting = cmp.get_config().completion.autocomplete
          if current_setting and #current_setting > 0 then
            cmp.setup({ completion = { autocomplete = false } })
            vim.notify("Autocomplete disabled")
          else
            cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
            vim.notify("Autocomplete enabled")
          end
        end
        vim.api.nvim_create_user_command("NvimCmpToggle", toggle_autocomplete, {})
        vim.api.nvim_set_keymap("n", "<Leader>bc", ":NvimCmpToggle<CR>", { noremap = true, silent = true })
        -- vim.keymap.set('n', '<leader>bc', toggle_buffer_completion, { noremap = true, silent = true })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.g.lsp_capabilities = capabilities
      end,
    },
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        require("mason-tool-installer").setup({
          -- :MasonToolsUpdate, slow to start
          -- Mason lspconfig only supports installing LSP tools (!?)
          run_on_start = true,
          debounce_hours = 6,
          ensure_installed = {
            "lua_ls",
            "stylua",

            "bash-language-server",
            "shellcheck",
            "shfmt",

            "tailwindcss-language-server",

            "vim-language-server",

            "rust-analyzer",
            "cpptools", -- Rust debugger

            "dockerfile-language-server",
            "hadolint", -- Dockerfiles

            --'fixjson',
            "json-lsp",

            -- writing
            -- 'remark-language-server',

            "goimports",
            "gofumpt",
            "gopls",
            "staticcheck",
            "vint",

            -- python
            "autopep8",
            "black",
            -- 'pyright', 'pyre',
            "mypy",
            "ruff",
            "isort",
            "flake8",

            -- 'solargraph',
            "sorbet",
            "ruby_lsp",

            "sql-formatter",

            "typescript-language-server",
            -- 'eslint-lsp',
            -- 'prettier',
          },
        })
      end,
    },
    {
      "j-hui/fidget.nvim", -- shows loading and stuff for LSP
      opts = {},
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-lspconfig").setup_handlers({
          -- The first entry (without a key) will be the default handler
          -- and will be called for each installed server that doesn't have
          -- a dedicated handler.
          function(server_name) -- default handler (optional)
            -- Basically just https://github.com/neovim/nvim-lspconfig
            require("lspconfig")[server_name].setup({
              on_attach = Simon_on_attach,
              capabilities = vim.g.lsp_capabilities,
              settings = server_name == "lua_ls" and {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  runtime = {
                    version = "LuaJIT",
                  },
                },
              } or {},
            })
          end,

          ["sorbet"] = function()
            require("lspconfig").sorbet.setup({
              on_attach = Simon_on_attach,
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
              settings = {
                -- Enable more aggressive type checking
                ruby = {
                  suggest = true,
                  diagnostics = true,
                },
              },
            })
          end,

          -- ['ruby_lsp'] = function ()
          --   require'lspconfig'.ruby_lsp.setup {
          --     on_attach = Simon_on_attach,
          --     capabilities = vim.g.lsp_capabilities,
          --     settings = servers[server_name],
          --     filetypes = { "ruby" }
          --   }
          -- end,
        })
      end,
    },
    {
      "nvimtools/none-ls.nvim", -- Create LS from shell tools
      -- Probably need to do this https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#using-local-executables
      config = function()
        local null_ls = require("null-ls")
        local methods = require("null-ls.methods")
        null_ls.setup({
          on_attach = Simon_on_attach,
          -- debug = true,
          sources = {
            -- How to install plugins when installed by Mason..?
            --   1. cd to ~/.local/share/nvim/mason/packages/flake8
            --   2. activate the venv: source venv/bin/activate
            -- https://github.com/williamboman/mason.nvim/issues/179#issuecomment-1198291091
            -- https://github.com/DmytroLitvinov/awesome-flake8-extensions
            --   pandas-vet flake8-bugbear flake8-simplify flake8-pie flake8-django
            -- https://github.com/williamboman/mason.nvim/issues/392 should fix!
            -- null_ls.builtins.diagnostics.flake8.with({
            --   extra_args = { "--max-line-length", "120" },
            -- }),
            null_ls.builtins.formatting.black.with({
              -- extra_args = { "--line-length", "120" },
            }),
            null_ls.builtins.formatting.isort,
            null_ls.builtins.diagnostics.mypy.with({
              command = "/Users/simon/.asdf/shims/mypy",
              method = methods.internal.DIAGNOSTICS_ON_SAVE,
            }),
            -- null_ls.builtins.formatting.autopep8,

            -- null_ls.builtins.formatting.fixjson,
            null_ls.builtins.formatting.stylua,

            null_ls.builtins.formatting.prettier,

            null_ls.builtins.formatting.goimports,
            -- Deprecated... maybe not by the time we're back to this
            -- null_ls.builtins.formatting.jq,

            -- null_ls.builtins.diagnostics.eslint,
            -- null_ls.builtins.formatting.eslint,

            -- null_ls.builtins.formatting.eslint_d,
            -- null_ls.builtins.diagonistics.eslint_d,
            -- null_ls.builtins.code_actions.xo -- Try xo an eslint wrapper if eslint not working?

            null_ls.builtins.diagnostics.hadolint, -- Dockerfiles
            -- null_ls.builtins.diagnostics.jsonlint,
            -- null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.code_actions.refactoring,
          },
        })
      end,
    },

    -- Fuzzy Finder --
    {
      "ibhagwan/fzf-lua",
      dependencies = { "kyazdani42/nvim-web-devicons" },
      config = function()
        actions = require("fzf-lua.actions")
        fzf = require("fzf-lua")
        fzf.register_ui_select()
        -- https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#default-options
        fzf.setup({
          winopts = {
            row = 1,
            col = 0.5,
            height = 0.2,
            width = 1,
            border = "none",
            backdrop = 100,
            title = false,
            preview = {
              horizontal = "right:50%",
              border = "border",
              title = false,
              scrollbar = false,
            },
          },
          previewers = {
            bat = {
              theme = "base16-256",
              args = "--color=always --style=numbers, --pager=never, --highlight-line=0",
            },
          },
          fzf_opts = {
            ["--ansi"] = "",
            ["--prompt"] = "> ",
            ["--info"] = "hidden",
            ["--height"] = "100%",
            ["--layout"] = "default",
            ["--cycle"] = "", -- Allow `<Up>` to go to the bottom
            ["--border"] = "none",
            ["--highlight-line"] = false,
            -- ['--color'] = 'bg:-1,fg:-1,fg+:-1,bg+:-1'
          },
          files = {
            cwd_prompt = false,
            prompt = "Files> ",
            -- Don't follow symlinks, weird behavior in JS repos.
            fd_opts = "--color=never --type f --hidden --exclude .git",
          },
          diagnostics = {
            severity_limit = "Error",
          },
          actions = {
            buffers = {
              ["default"] = actions.buf_edit,
              ["ctrl-x"] = actions.buf_split,
              ["ctrl-v"] = actions.buf_vsplit,
              ["ctrl-t"] = actions.buf_tabedit,
            },
            files = {
              ["default"] = actions.file_edit_or_qf,
              ["ctrl-x"] = actions.file_split,
              ["ctrl-v"] = actions.file_vsplit,
              ["ctrl-t"] = actions.file_tabedit,
              ["alt-q"] = actions.file_sel_to_qf,
            },
          },
          buffers = {
            actions = {
              ["ctrl-x"] = actions.buf_split,
              ["ctrl-d"] = { actions.buf_del, actions.resume },
            },
          },
        })

        vim.cmd([[
        " Define a command :Gco for git_branches
        command! Gco lua require("fzf-lua").git_branches()

        map <C-p>        :lua require('fzf-lua').files()<CR>
        map <A-t>        :lua require("fzf-lua").git_status()<CR>t

        map <C-j>        :lua require('fzf-lua').buffers()<CR>

        map z=           :lua require("fzf-lua").spell_suggest()<CR>
        map <Space>'     :lua require("fzf-lua").marks()<CR>

        map <C-q>        :lua require('fzf-lua').commands()<CR>

        map <C-g>        :lua require('fzf-lua').live_grep_native()<CR>
        map <Space>/     :lua require('fzf-lua').grep_cword()<CR>
        map <Leader>/    :lua require('fzf-lua').grep()<CR>

        map <C-l>        :lua require('fzf-lua').tags()<CR>
        map <A-l>        :lua require('fzf-lua').btags()<CR>
        map <Space>l     :lua require('fzf-lua').tags({ fzf_opts = { ["--query"] = vim.fn.expand("<cword>") }})<CR>
        map <Space><A-l> :lua require('fzf-lua').btags({ fzf_opts = { ["--query"] = vim.fn.expand("<cword>") }})<CR>
      ]])
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      keys = { { "\\t" } },
      dependencies = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      },
      config = function()
        require("nvim-tree").setup({})
        vim.cmd([[ map \t :NvimTreeToggle<CR> ]])
      end,
    },
    {
      "preservim/vim-markdown",
      ft = { "markdown" },
      config = function()
        vim.cmd([[
        let g:vim_markdown_new_list_item_indent = 2
        let g:vim_markdown_folding_disabled = 1
        let g:vim_markdown_frontmatter = 1
        let g:vim_markdown_auto_insert_bullets = 1
        let g:vim_markdown_math = 1
      ]])
      end,
    },
    { "vim-ruby/vim-ruby",     ft = { "ruby", "eruby" } },
    {
      "tpope/vim-rails",
      config = function()
        vim.cmd([[
          nmap <Leader>a :vsp<cr>:A<CR>
          nmap <Leader>r :vsp<cr>:R<CR>
        ]])
      end,
    },
    { "fatih/vim-go" },
    { "prisma/vim-prisma" },
    { "jparise/vim-graphql" },
    { "wakatime/vim-wakatime", lazy = false },
  })

  vim.o.updatetime = 250
  vim.cmd([[
    augroup LSPDiagnosticsOnHover
    autocmd!
    autocmd CursorHold *   lua vim.diagnostic.open_float(nil, { focusable = false, relative = 'cursorHold' })
    augroup END
  ]])
end

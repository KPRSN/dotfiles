-- Set <space> as the leader key. Must be done before packages/plugins.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Catppuccin colorscheme...
local colorscheme = {
  repo = 'catppuccin/nvim',
  name = 'catppuccin',
}
-- ...or Dracula...
-- local colorscheme = {
--   repo = 'dracula/vim',
--   name = 'dracula',
-- }
-- ...or good old Nord.
-- local colorscheme = {
--   repo = 'arcticicestudio/nord-vim',
--   name = 'nord',
-- }

-- Install package/plugin manager.
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

-- Install packages/plugins.
require('lazy').setup({
  "f-person/auto-dark-mode.nvim",   -- Automatically switch on darkmode.
  'gennaro-tedesco/nvim-peekup',    -- Peek at registers.
  'nathanalderson/yang.vim',        -- YANG syntax.
  'neovim/nvim-lspconfig',          -- Default LSP configs.
  'ntpeters/vim-better-whitespace', -- StripWhitespace for trailing spaces (could be replaced by mini).
  'tpope/vim-abolish',              -- Preserve case substitute neatly with :S.
  'tpope/vim-fugitive',             -- A lot of GIT.
  'tpope/vim-repeat',               -- Let plugins repeat stuff with dot.
  'vim-scripts/DoxygenToolkit.vim', -- Generate doxygen headers.

  -- A little bit of everything.
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.ai').setup()        -- Extend and create a/i textobjects.
      require('mini.align').setup()     -- Align stuff with ga.
      require('mini.bracketed').setup() -- More bindings for square brackets.
      require('mini.comment').setup()   -- Comment stuff out with gc.
      require('mini.pairs').setup()     -- Pair parenthesis automagically.

      -- Visualize indentation.
      require('mini.indentscope').setup({
        draw = {
          delay = 250,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        options = {
          indent_at_cursor = false,
        }
      })
    end,
  },

  -- Make LSP-based formatting behave.
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = {"stylua"},
          go = {"gofmt", "golines"},
        },
        formatters = {
          golines = {
              args = { "--max-len=120", "--shorten-comments" }
          },
        },
      })
    end,
    init = function()
      -- Make 'gq' use conform with a reasonable timeout (for slow ass formatting).
      vim.o.formatexpr = [[v:lua.require("conform").formatexpr({"timeout_ms":30000})]]
    end,
  },

  -- Autocompletion at the flick of a button.
  {
    'saghen/blink.cmp',
    opts = {
      -- Show completion menu on <C-n> instead of the default <C-space>.
      keymap = {
        preset = 'none',

        ['<C-n>'] = { 'show' , 'select_next', 'fallback_to_mappings' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },

      -- Disable automatic completion, for us old-fashioned souls.
      completion = {
        menu = {
          auto_show = false,
        },
      },

      -- Dependency-free fuzzieness.
      fuzzy = { implementation = 'lua' },

      -- Function signatures, yes please.
      signature = { enabled = true },
    },
  },

  -- Reopen files at last known position.
  {
    'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup({
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
      })
    end,
  },

  -- Delimit words by underscores and camel cases.
  {
    'chrisgrieser/nvim-spider',
    config = function()
      vim.keymap.set({'n', 'o', 'x'}, 'w', '<cmd>lua require("spider").motion("w")<CR>', { desc = 'Spider-w' })
      vim.keymap.set({'n', 'o', 'x'}, 'e', '<cmd>lua require("spider").motion("e")<CR>', { desc = 'Spider-e' })
      vim.keymap.set({'n', 'o', 'x'}, 'b', '<cmd>lua require("spider").motion("b")<CR>', { desc = 'Spider-b' })
      vim.keymap.set({'n', 'o', 'x'}, 'ge', '<cmd>lua require("spider").motion("ge")<CR>', { desc = 'Spider-ge' })
    end,
  },

  -- Highlight long lines.
  {
    'lcheylus/overlength.nvim',
    config = function()
      require('overlength').setup({
        default_overlength = 120,
      })
      require('overlength').set_overlength('python', 120)
      require('overlength').set_overlength('c', 120)
      require('overlength').set_overlength('cpp', 120)
      require('overlength').set_overlength('vim', 120)
      require('overlength').set_overlength('bash', 120)
      require('overlength').set_overlength('yaml', 120)
      require('overlength').set_overlength('lua', 120)
    end,
  },


  -- Hide cursorline when inactive.
  {
    'amarakon/nvim-unfocused-cursor',
    config = function()
      require('unfocused-cursor').setup()
    end,
  },

  -- Set colorscheme based on variable.
  {
    colorscheme.repo,
    name = colorscheme.name,
    lazy = false,    -- Load colorscheme during startup.
    priority = 1000, -- Load before all other start plugins.
    config = function()
      require('catppuccin').setup({
        background = { -- :h background
          light = "latte",
          dark = "macchiato",
        },
      })
      vim.cmd("colorscheme " .. colorscheme.name)
    end,
  },

  -- Status line.
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = colorscheme.name,
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- Git right in the gutter.
  {
    'lewis6991/gitsigns.nvim',
    lazy = false, -- Make the gutter come to life.
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      { '<leader>gs', function() require("gitsigns").stage_hunk() end },
      { '<leader>gu', function() require("gitsigns").reset_hunk() end },
      { '<leader>gp', function() require("gitsigns").preview_hunk() end },
      { '<leader>g[', function() require("gitsigns").prev_hunk() end },
      { '<leader>g]', function() require("gitsigns").next_hunk() end },
    },
  },


  -- Fuzzy finding.
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })
    end,
    keys = {
      { '<leader>ff', function() require("telescope.builtin").find_files() end },
      { '<leader>fb', function() require("telescope.builtin").buffers() end },
      { '<leader>bb', function() require("telescope.builtin").buffers() end },
      { '<leader>fg', function() require("telescope.builtin").live_grep() end },
      { '<leader>*', function() require("telescope.builtin").grep_string() end },
      { '<leader>s', function() require("telescope.builtin").current_buffer_fuzzy_find() end },
      { '<leader>gr', function() require("telescope.builtin").lsp_references() end },
      { '<leader>gd', function() require("telescope.builtin").lsp_definitions() end },
      { '<leader>gi', function() require("telescope.builtin").lsp_implementations() end },
    },
  },

  -- Natively fuzzy.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
})

local opts = { noremap=true, silent=true }

-- I see your true colors shining through.
vim.o.termguicolors = true

-- Relative/hybrid line numbering.
vim.wo.relativenumber = true
vim.wo.number = true

-- Tabs are four spaces.
vim.o.tabstop = 4      -- Tabs look like 4 spaces.
vim.o.shiftwidth = 4   -- Number of spaces inserted on indentation.
vim.o.softtabstop = 4  -- Number of spaces inserted when tab is pressed.
vim.o.expandtab = true -- Tabs are expanded to spaces.

-- Case insensitive-ish search.
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true

-- Split new windows below and to the right.
vim.o.splitbelow = true
vim.o.splitright = true

-- Give windows a bit of bling.
vim.o.winborder = 'rounded'

-- Make sign column and friends a bit snappier.
vim.o.updatetime = 250

-- Always show the sign column.
vim.o.signcolumn = 'yes'

-- Set nice symbols and enable virtual text for diagnostics.
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "󰟃",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
})

-- Quickly remove search highlighting.
vim.keymap.set('n', '<leader><leader>', ':nohlsearch<CR>', opts)

-- Git going.
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')

-- Snappy window switching.
vim.keymap.set('n', '<leader>h', '<C-w>h', opts)
vim.keymap.set('n', '<leader>j', '<C-w>j', opts)
vim.keymap.set('n', '<leader>k', '<C-w>k', opts)
vim.keymap.set('n', '<leader>l', '<C-w>l', opts)

-- Opening and closing windows.
vim.keymap.set('n', '<leader>w/', ':vs<CR>', opts)
vim.keymap.set('n', '<leader>w-', ':sp<CR>', opts)

-- Navigating tabs.
vim.keymap.set('n', '<leader>t', ':tabnew<CR>', opts)
vim.keymap.set('n', '<leader>T', ':tabclose<CR>', opts)
vim.keymap.set('n', '<leader>n', 'gt', opts)
vim.keymap.set('n', '<leader>p', 'gT', opts)
vim.keymap.set('n', '<leader>1', '1gt', opts)
vim.keymap.set('n', '<leader>2', '2gt', opts)
vim.keymap.set('n', '<leader>3', '3gt', opts)
vim.keymap.set('n', '<leader>4', '4gt', opts)
vim.keymap.set('n', '<leader>5', '5gt', opts)
vim.keymap.set('n', '<leader>6', '6gt', opts)
vim.keymap.set('n', '<leader>7', '7gt', opts)
vim.keymap.set('n', '<leader>8', '8gt', opts)
vim.keymap.set('n', '<leader>9', '9gt', opts)

-- Toggle previous buffer.
vim.keymap.set('n', '<leader><tab>', '<C-^>', opts)

-- And a sprinkle of LSP.
vim.lsp.enable('clangd')
vim.lsp.enable('gopls')
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('v', '<leader>qf', vim.lsp.buf.format, opts)
vim.keymap.set('n', '<leader>fa', '<cmd>ClangdSwitchSourceHeader<cr>', opts)

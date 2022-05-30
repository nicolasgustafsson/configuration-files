-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
--vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Package manager
	use 'tpope/vim-fugitive' -- Git commands in nvim
	use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
	use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
	--use 'ludovicchabant/vim-gutentags' -- Automatic tags management - Doesn't work on cpp files for me :///
	-- UI to select things (files, grep results, open buffers...)
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use 'nvim-lualine/lualine.nvim' -- Fancier statusline
	-- Add indentation guides even on blank lines
	use 'lukas-reineke/indent-blankline.nvim'
	-- Add git related info in the signs columns and popups
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use 'nvim-treesitter/nvim-treesitter'
	-- Additional textobjects for treesitter
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip' -- Snippets plugin
	use 'williamboman/nvim-lsp-installer' -- Lsp installer plugin
	use 'rmehri01/onenord.nvim' --Best color theme I've found
--	use 'stevearc/aerial.nvim' -- lists functions
	use 'phaazon/hop.nvim' -- quick navigation
	use 'Shatur/neovim-cmake' -- CMake integration
	use 'mfussenegger/nvim-dap' -- Debug-Adapter. for debugging!
	use 'gelguy/wilder.nvim' -- Better wild menu
	use {"nvim-neo-tree/neo-tree.nvim", branch = "v2.x", requires = {'nvim-lua/plenary.nvim', "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim"}} -- For file trees(but can also be used for other kind of trees)
	use 'echasnovski/mini.nvim' --collection of small self-contained plugins
	use 'windwp/nvim-projectconfig' --per project lua config
	use 'Pocco81/AutoSave.nvim' --Auto save
	--use 'ilyachur/cmake4vim' --cmake integration
	use 'stevearc/dressing.nvim' --dressing (cooler picker windows)
	use 'folke/which-key.nvim' --keybinding helper
	use 'ray-x/lsp_signature.nvim' --function signature helper
	use 'nvim-telescope/telescope-dap.nvim' --telescope dap integration
	use 'theHamsta/nvim-dap-virtual-text' --virtual text for dap
	use 'rcarriga/nvim-dap-ui' --dap UI
	use({'catppuccin/nvim', as = "catpppuccin"}) --pastel theme
end)

--diagnose lsp errors
-- vim.lsp.set_log_level("debug")

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = false

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Tab settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

--Decrease update time
vim.o.updatetime = 150
vim.wo.signcolumn = 'yes'

--Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'nightfly',
    component_separators = '|',
    section_separators = '',
  },
}

--Enable Comment.nvim
require('Comment').setup({})

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '4', '<C-O>')
vim.keymap.set('n', '+', '<C-I>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'dap'

--Add navigation shortcuts
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files)
vim.keymap.set('n', 'ts', require('telescope.builtin').lsp_dynamic_workspace_symbols)
vim.keymap.set('n', 'tb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', 'tn', require('telescope.builtin').lsp_definitions)
vim.keymap.set('n', 'tf', function()
	require('telescope.builtin').lsp_document_symbols {symbols = {'function'}}
end)
vim.keymap.set('n', 'tr', require('telescope.builtin').lsp_references)
vim.keymap.set('n', 'tl', require('telescope.builtin').buffers)
vim.keymap.set('n', 'to', "<cmd>ClangdSwitchSourceHeader<cr>")
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

--Add build shortcuts
vim.keymap.set('n', 'lb', require('cmake').build)
vim.keymap.set('n', 'lr', require('cmake').build_and_run)
vim.keymap.set('n', 'lc', require('cmake').clean)
vim.keymap.set('n', 'ld', require('cmake').build_and_debug)
vim.keymap.set('n', 'lx', require('cmake').cancel)

--Add debug shortcuts
vim.keymap.set('n', ')', "<cmd>:DapStepOver<cr>")
vim.keymap.set('n', '[', "<cmd>:DapStepInto<cr>")
vim.keymap.set('n', '{', "<cmd>:DapStepOut<cr>")
vim.keymap.set('n', '(', "<cmd>:DapToggleBreakpoint<cr>")
vim.keymap.set('n', '|', "<cmd>:DapContinue<cr>")

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic keymaps
--vim.keymap.set('n', 'te', vim.diagnostic.open_float)
vim.keymap.set('n', 'tp', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'te', vim.diagnostic.goto_next)
vim.keymap.set('n', 'tq', vim.diagnostic.setloclist)
--vim.keymap.set('n', 'jb', require(''))

-- LSP settings
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'hh', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'hs', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'hc', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'hr', vim.lsp.buf.rename, opts)
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
  --require('aerial').on_attach(client, bufnr)
  require('lsp_signature').on_attach(client, bufnr)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = false

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require("nvim-lsp-installer").setup({})

local lspconfig = require("lspconfig")
lspconfig.sumneko_lua.setup(
	{
		on_attach = on_attach,
		capabilities = capabilities,
		settings =
		{
			Lua =
			{
				diagnostics  ={ globals = {'vim'} },
				telemetry = { enable = false },
				workspace = { library = vim.api.nvim_get_runtime_file('', true) },
				runtime =
				{
					--version = 'LuaJIT',
					path = runtime_path,
				}
			}
		}
	}
)

lspconfig.clangd.setup(
	{
		on_attach = on_attach,
		capabilities = capabilities,

		cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--clang-tidy", "--completion-style=bundled", "--header-insertion=iwyu",} --"--log=verbose"}

	}
)

-- luasnip setup
local luasnip = require 'luasnip'
-- luasnip.expand_auto = true
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm
	{
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    --{ name = 'luasnip' },
  },
}

--Theming
require('catppuccin').setup({})
-- require('onenord').setup({
--   theme = nil
-- });
vim.g.catppuccin_flavour = "frappe"
vim.cmd[[colorscheme catppuccin]]

--aerial setup
-- require('aerial').setup({
-- 		open_automatic = true
-- });

-- Show line diagnostics automatically in hover window
vim.diagnostic.config({virtual_text = false})
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

--Hop setup
require('hop').setup();
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({  })<cr>", {})
vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ inclusive_jump = true })<cr>", {})

--Tabbing keymaps
vim.keymap.set('n','<C-Tab>', "<cmd>:wincmd w<cr>")
vim.keymap.set('n', '<C-S-Tab>', "<cmd>:wincmd <S-w><cr>")

--cmake integration
--not a lua extension, no need to run setup?
--vim.g.cmake_build_type = "Debug"
--vim.g.cmake_reload_after_save = 1

--wilder setup
require('wilder').setup({modes = {':', '/', '?'}});

--Neo-tree setup
require('neo-tree').setup({modifiable = true})

--Autosave
require("autosave").setup({});

--mini-nvim setup
require('mini.starter').setup({});

--lsp_signature setup
require('lsp_signature').setup(
{
	bind = true,
	fix_pos = true,
	hint_enable = false,
	always_trigger = true,
	extra_trigger_chars = {',', '{', '(', ' '}
});

--Debug adapter

local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/nicos/Misc/vscode-cpptools/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-10', -- adjust as needed, must be absolute path
  name = 'lldb'
}

-- dap.adapters.codelldb = {
--   type = 'executable',
--   command = '/home/nicos/Misc/codelldb/extension/adapter/codelldb',
--   name = 'codelldb'
-- }

local cmd = '/home/nicos/Misc/codelldb/extension/adapter/codelldb'
dap.adapters.codelldb = function(on_adapter)
  -- This asks the system for a free port
  local tcp = vim.loop.new_tcp()
  tcp:bind('127.0.0.1', 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()

  -- Start codelldb with the port
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local opts = {
    stdio = {nil, stdout, stderr},
    args = {'--port', tostring(port)},
  }
  local handle
  local pid_or_err
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  if not handle then
    vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
    stdout:close()
    stderr:close()
    return
  end
  vim.notify('codelldb started. pid=' .. pid_or_err)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  local adapter = {
    type = 'server',
    host = '127.0.0.1',
    port = port
  }
  -- 💀
  -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
  -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
  vim.defer_fn(function() on_adapter(adapter) end, 500)
end

require("nvim-dap-virtual-text").setup();
local dapui = require("dapui");
dapui.setup({});
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
--cmake

require('cmake').setup({
  dap_configuration = {
    type = 'codelldb',
	-- type = 'lldb',
    request = 'launch',
    stopOnEntry = false,
    runInTerminal = false,
	terminal = 'console',
  },
  dap_open_command = false,
  quickfix_only_on_error = true
})

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')--vim.fn.input('Path to executable: ', executable_path, 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
	terminal = 'external',

    --runInTerminal = false,

    --postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
  },}
--nvim-projectconfig should be last, to make project specific commands happen after this
require('nvim-projectconfig').setup({autocmd = true});

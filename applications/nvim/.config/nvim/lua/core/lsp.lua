-- LSP servers contained in root/lsp

-- Add to the list below for them to be enabled
vim.lsp.enable({
  "lua-language-server",
  "pyright",
  "bashls",
  "texlab",
  "clangd"
})


-- Native completion and custom keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local set = vim.keymap.set
    local buf = vim.lsp.buf
    local opts = {
      noremap = true,
      silent = true,
      buffer = ev.buf
    }

    -- The following keymaps are shared by all LSPs
    set("n", "gd", buf.definition, opts)
    set("n", "gD", buf.declaration, opts)
    set("n", "gr", buf.references, opts)
    set("n", "gR", buf.rename, opts)
    set("n", "gi", buf.implementation, opts)
    set("n", "K", buf.hover, opts)
    set("n", "<leader>rn", buf.rename, opts)
    set("n", "<leader>ca", buf.code_action, opts)

    -- formats code if available
    if client.server_capabilities.documentFormattingProvider then
      set("n", "<leader>F", buf.format, opts)
    end

    -- Completion setup
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

  end,
})

vim.cmd("set completeopt+=noselect")

vim.o.winborder = "rounded"

-- Native diagnostics
vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true,
  underline = false

  -- Alternatively, customize specific options
  -- virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor lline
    -- current_line = true,
  -- },
})

-- Enables inlay hints
vim.lsp.inlay_hint.enable(true)


-- Roslyn specific settings
vim.lsp.config("roslyn", {
    cmd = {
        "roslyn",
        "--stdio",
        "--logLevel",
        "Information",
        "--extensionLogDirectory",
        vim.fn.stdpath("state") .. "/roslyn",
    },
    on_attach = function()
        print("Rosyln LSP started!")
    end,
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
        },
    },
})

-- Toggling inlay hints (ex. in C# the object type)
vim.keymap.set('n', '<leader>th',
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = '[T]oggle Inlay [H]ints' }
)

-- Toggling LSP Errors altogether
vim.keymap.set('n', '<leader>te', function()
    local cfg = vim.diagnostic.config()
    vim.diagnostic.config({
      virtual_lines = not cfg.virtual_lines,
      underline = cfg.underline,
    })
  end, { desc = '[T]oggle LSP [E]rrors' }
)

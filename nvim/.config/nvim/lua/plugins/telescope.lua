return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local telescope = require("telescope")
    local previewers = require("telescope.previewers")

    local function markdown_safe_previewer_maker(filepath, bufnr, opts)
      opts = opts or {}
      local expanded = vim.fn.expand(filepath)
      local is_markdown = expanded:match("%.md$")
        or expanded:match("%.markdown$")
        or expanded:match("%.mdown$")

      if is_markdown then
        previewers.buffer_previewer_maker(expanded, bufnr, vim.tbl_extend("force", opts, {
          use_ft_detect = false,
        }))

        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            pcall(vim.treesitter.stop, bufnr)
            vim.bo[bufnr].filetype = "text"
            vim.bo[bufnr].syntax = "OFF"
          end
        end)

        return
      end

      previewers.buffer_previewer_maker(expanded, bufnr, opts)
    end

    -- setup block
    telescope.setup({
      defaults = {
        buffer_previewer_maker = markdown_safe_previewer_maker,
        path_display = { "filename_first" }, -- Shows filename, then directory (fixes overflow)
        layout_strategy = 'horizontal',
        layout_config = {
          width = 0.95, -- Uses 95% of your screen width
          preview_width = 0.5,
        },
        mappings = {
          i = {
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<CR>"] = function(prompt_bufnr)
              local picker = action_state.get_current_picker(prompt_bufnr)
              local multi = picker:get_multi_selection()

              if vim.tbl_isempty(multi) then
                actions.select_default(prompt_bufnr)
              else
                actions.close(prompt_bufnr)
                for _, entry in ipairs(multi) do
                  local filename = entry.path or entry.filename or entry.value
                  if filename then
                    vim.cmd.edit(vim.fn.fnameescape(filename))
                  end
                end
              end
            end,
          },
          n = {
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<CR>"] = function(prompt_bufnr)
              local picker = action_state.get_current_picker(prompt_bufnr)
              local multi = picker:get_multi_selection()

              if vim.tbl_isempty(multi) then
                actions.select_default(prompt_bufnr)
              else
                actions.close(prompt_bufnr)
                for _, entry in ipairs(multi) do
                  local filename = entry.path or entry.filename or entry.value
                  if filename then
                    vim.cmd.edit(vim.fn.fnameescape(filename))
                  end
                end
              end
            end,
          },
        },
      }
    })
    -- custom keymaps
    local set = vim.keymap.set
    local builtin = require("telescope.builtin")

    -- goes into nvim config folder from anywhere
    local pull_dotfiles = function()
      builtin.find_files( { cwd = vim.fn.stdpath("config") })
    end

    set("n", "<C-d>", pull_dotfiles, { desc = "Find nvim config dir" })
    set("n", "<C-f>", builtin.find_files, { desc = "Find files in cwd" })
    set("n", "<leader>gs", builtin.live_grep, { desc = "Live grep" })
    set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
    set("n", "<leader>E", function() builtin.diagnostics({ bufnr = 1 }) end, { desc = "Buffer diagnostics" })
    set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open a floating window with the full diagnostic message" })
 end
}


return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    require("lualine").setup {
      options = {
        theme = "codedark",
        globalstatus = true
      },
      sections = {
        lualine_a = {'filename'},
        lualine_b = {'diff'},
        lualine_c = {'diagnostics'},

        lualine_x = {'filetype'},
        lualine_y = {
          {
            'branch',
            fmt = function(str)
              if str == nil then return "" end
              return str:sub(1, 20)
            end
          },
        },
        lualine_z = {
          {
            'filename',
            file_status = true,
            path = 1,
            fmt = function(str)
              local parts = {}
              for part in string.gmatch(str, "([^/]+)") do
                table.insert(parts, part)
              end
              local n = #parts
              if n > 3 then
                return parts[n-2] .. "/" .. parts[n-1] .. "/" .. parts[n]
              end
              return str
            end
          }
        },
      }
    }
  end
}


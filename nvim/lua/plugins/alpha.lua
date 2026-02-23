-- alpha dashboard plugin

return {
  {
    'goolord/alpha-nvim',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {
        [[        ___                     ___          _____         ]],
        [[       /  /\      ___          /__/\        /  /::\        ]],
        [[      /  /:/_    /  /\         \  \:\      /  /:/\:\       ]],
        [[     /  /:/ /\  /  /:/          \  \:\    /  /:/  \:\      ]],
        [[    /  /:/ /:/ /__/::\      _____\__\:\  /__/:/ \__\:|     ]],
        [[   /__/:/ /:/  \__\/\:\__  /__/::::::::\ \  \:\ /  /:/     ]],
        [[   \  \:\/:/      \  \:\/\ \  \:\~~\~~\/  \  \:\  /:/      ]],
        [[    \  \::/        \__\::/  \  \:\  ~~~    \  \:\/:/       ]],
        [[     \  \:\        /__/:/    \  \:\         \  \::/        ]],
        [[      \  \:\       \__\/      \  \:\         \__\/         ]],
        [[       \__\/                   \__\/                       ]],
        [[        ___                       ___           ___        ]],
        [[       /  /\                     /  /\         /__/\       ]],
        [[      /  /:/_                   /  /::\       _\_ \:\      ]],
        [[     /  /:/ /\  ___     ___    /  /:/\:\     /__/\ \:\     ]],
        [[    /  /:/ /:/ /__/\   /  /\  /  /:/  \:\   _\_ \:\ \:\    ]],
        [[   /__/:/ /:/  \  \:\ /  /:/ /__/:/ \__\:\ /__/\ \:\ \:\   ]],
        [[   \  \:\/:/    \  \:\  /:/  \  \:\ /  /:/ \  \:\ \:\/:/   ]],
        [[    \  \::/      \  \:\/:/    \  \:\  /:/   \  \:\ \::/    ]],
        [[     \  \:\       \  \::/      \  \:\/:/     \  \:\/:/     ]],
        [[      \  \:\       \__\/        \  \::/       \  \::/      ]],
        [[       \__\/                     \__\/         \__\/       ]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', '<cmd>ene <CR>'),
        dashboard.button('SPC f o', '󰈞  Recently opened files'),
        dashboard.button('q', '󰅚  Quit NVIM', ':qa<CR>'),
      }
      local handle = io.popen 'fortune'
      local fortune = handle:read '*a'
      handle:close()
      dashboard.section.footer.val = fortune

      dashboard.config.opts.noautocmd = true

      vim.cmd [[autocmd User AlphaReady echo 'ready']]

      alpha.setup(dashboard.config)
    end,
  },
}

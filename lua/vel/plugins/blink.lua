return {
  {
    "saghen/blink.cmp",

    event = "InsertEnter",

    -- optional: provides snippets for the snippet source
    dependencies = { "moyiz/blink-emoji.nvim", "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "default",
        -- ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
      },

      signature = { enabled = true },

      cmdline = { enabled = true },

      snippets = { preset = "luasnip" },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji" },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,        -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
            should_show_items = function()
              return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
                { "gitcommit", "markdown" },
                vim.o.filetype
              )
            end,
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    'saghen/blink.pairs',
    dependencies = 'saghen/blink.lib',

    -- download prebuilt binaries from github releases
    version = '*', -- must be on a versioned release to download
    build = function() require('blink.pairs').download():pwait(60000) end,
    -- OR build from source
    -- build = function() require('blink.pairs').build():pwait(60000) end,

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        -- you can call require("blink.pairs.mappings").enable()
        -- and require("blink.pairs.mappings").disable()
        -- to enable/disable mappings at runtime
        enabled = true,
        cmdline = true,
        -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
        -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
        disabled_filetypes = {},
        wrap = {
          -- move closing pair via motion
          ['<C-b>'] = 'motion',
          -- move opening pair via motion
          ['<C-S-b>'] = 'motion_reverse',
          -- set to 'treesitter' or 'treesitter_reverse' to use treesitter instead of motions
          -- set to nil, '' or false to disable the mapping
          -- normal_mode = {} <- for normal mode mappings, only supports 'motion' and 'motion_reverse'
        },
        -- see the defaults:
        -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52
        pairs = {},
      },
      highlights = {
        enabled = true,
        -- requires require('vim._core.ui2').enable({}), otherwise has no effect
        cmdline = true,
        -- set to { 'BlinkPairs' } to disable rainbow highlighting
        groups = { 'BlinkPairsOrange', 'BlinkPairsPurple', 'BlinkPairsBlue' },
        unmatched_group = 'BlinkPairsUnmatched',

        -- highlights matching pairs under the cursor
        matchparen = {
          enabled = true,
          -- known issue where typing won't update matchparen highlight, disabled by default
          cmdline = false,
          -- also include pairs not on top of the cursor, but surrounding the cursor
          include_surrounding = true,
          group = 'BlinkPairsMatchParen',
          priority = 250,
        },
      },
      debug = false,
    }
  },
  {
    'saghen/blink.indent',
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    -- opts = {},
  }
}

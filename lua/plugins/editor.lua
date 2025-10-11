return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    priority = 1000,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        ";f",
        function()
          require("telescope.builtin").find_files({ no_ignore = false, hidden = true })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";r",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Search for a string in your current working directory",
      },
      {
        "sb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";;",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        ";e",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Lists diagnostics for buffers",
      },
      {
        ";s",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "Lists functions and variables from Treesitter",
      },
      {
        "sf",
        function()
          local telescope = require("telescope")
          local fb = telescope.extensions.file_browser
          if not fb then
            vim.notify("Telescope file_browser extension not loaded", vim.log.levels.WARN)
            return
          end

          fb.file_browser({
            path = "%:p:h",
            cwd = vim.fn.expand("%:p:h"),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open file browser at current buffer path",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = (telescope.extensions.file_browser and telescope.extensions.file_browser.actions) or {}

      opts = opts or {}
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = { n = {} },
      })

      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = { preview_cutoff = 9999 },
        },
      })

      opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            n = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["<C-u>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
            },
          },
        },
      })

      telescope.setup(opts)

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "file_browser")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}

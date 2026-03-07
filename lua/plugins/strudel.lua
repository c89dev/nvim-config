return {
  {
    "gruvw/strudel.nvim",
    build = "npm ci",

    opts = {
      ui = {
        maximise_menu_panel = true,
        hide_menu_panel = false,
        hide_top_bar = false,
        hide_code_editor = false,
        hide_error_display = true,
      },
      start_on_launch = true,
      update_on_save = true,
      sync_cursor = true,
      report_eval_errors = true,
      headless = false,
      browser_data_dir = "~/.cache/strudel-nvim/",
      browser_exec_path = "/usr/bin/chromium",
    },

    keys = {
      { "<leader>sl", function() require("strudel").launch() end, desc = "Launch Strudel" },
      { "<leader>sq", function() require("strudel").quit() end, desc = "Quit Strudel" },
      { "<leader>st", function() require("strudel").toggle() end, desc = "Toggle Strudel" },
      { "<leader>su", function() require("strudel").update() end, desc = "Strudel Update" },
      { "<leader>ss", function() require("strudel").stop() end, desc = "Strudel Stop" },
      { "<leader>sb", function() require("strudel").set_buffer() end, desc = "Set Strudel Buffer" },
      { "<leader>sx", function() require("strudel").execute() end, desc = "Execute Strudel Buffer" },
    },
  },
}

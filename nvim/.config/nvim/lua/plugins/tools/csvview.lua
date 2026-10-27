return {
  "hat0uma/csvview.nvim",
  ft = { "csv", "tsv" },
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      textobject_field_in = { "if", mode = { "o", "x" } },
      textobject_field_around = { "af", mode = { "o", "x" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
}

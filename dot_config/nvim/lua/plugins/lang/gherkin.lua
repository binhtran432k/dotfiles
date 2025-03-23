return {
  {
    "binhtran432k/tree-sitter-gherkin",
    dev = true,
    build = "mkdir parser && tree-sitter build -o parser/gherkin.so",
    ft = "cucumber",
    init = function()
      vim.treesitter.language.register("gherkin", "cucumber")
    end,
  },
}

local chatgpt = require('chatgpt')
chatgpt.setup({
  openai_params = {
    model = "gpt-4o-mini",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 1000,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  actions_paths = {},
  show_quickfixes_cmd = "Telescope quickfix",
  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/denn1s/awesome-chatgpt-prompts/main/prompts.csv"
})

vim.keymap.set("v", "<leader>a", function() chatgpt.edit_with_instructions() end, { desc = "ChatGPT: Edit with instructions" })

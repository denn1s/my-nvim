require('chatgpt').setup({
  openai_params = {
    model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 300,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  actions_paths = {},
  show_quickfixes_cmd = "Telescope quickfix",
  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv"
})

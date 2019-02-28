use Mix.Config

config :ex_gram,
  token: {:system, "BOT_TOKEN"}

config :acm_bot,
  # prices_file: "ejemplo.pdf"
  prices_file: {:system, "PRICES_PATH", default: "path/to/file"}

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ex_gram,
  token: {:system, "BOT_TOKEN"}

config :acm_bot,
  # prices_file: "ejemplo.pdf"
  prices_file: {:system, "PRICES_PATH"}

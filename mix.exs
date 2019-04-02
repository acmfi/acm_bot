defmodule AcmBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :acm_bot,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AcmBot, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_gram, "~> 0.5.0"},
      # Releases
      {:distillery, "~> 2.0", runtime: false},
      {:config_tuples, "~> 0.2"},
      {:jason, "~> 1.1"}
    ]
  end
end

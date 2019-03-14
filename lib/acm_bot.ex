defmodule AcmBot do
  use Application

  require Logger

  def start(_, _) do
    token = ExGram.Config.get(:ex_gram, :token)

    children = [
      ExGram,
      {AcmBot.Bot, [method: :polling, token: token]},
      AcmBot.Cache
    ]

    opts = [strategy: :one_for_one, name: AcmBot]

    case Supervisor.start_link(children, opts) do
      {:ok, _} = ok ->
        Logger.info("Starting AcmBot")
        ok

      error ->
        Logger.error("Error starting AcmBot")
        error
    end
  end
end

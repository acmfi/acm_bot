defmodule AcmBot.Board do
  require Logger

  def info() do
    board_file_path = ExGram.Config.get(:acm_bot, :board_file)

    case File.read(board_file_path) do
      {:ok, file} -> Jason.decode(file)
      err -> err
    end
  end
end

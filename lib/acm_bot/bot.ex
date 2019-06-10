defmodule AcmBot.Bot do
  @bot :acm_bot

  use ExGram.Bot,
    name: @bot

  middleware(ExGram.Middleware.IgnoreUsername)

  require Logger

  def bot(), do: @bot

  command("start")
  command("armario")
  command("junta")

  def handle({:command, :start, _message}, context) do
    answer(context, "Hola buenas tardes!\nEste es el nuevo bot de ACM.")
  end

  def handle({:command, :junta, _message}, context) do
    case AcmBot.Board.info() do
      {:ok, board_info} ->
        message = board_info |> Stream.map(&format_board_member/1) |> Enum.join("\n")
        answer(context, message, parse_mode: "Markdown")

      _ ->
        answer(
          context,
          "Ups parece que no disponemos de la información de la junta ahora mismo. Puedes molestar a alguien para que lo arregle :D"
        )
    end
  end

  # Versión precaria del comando armario. Es muy mejorable con las ideas de @Ironjanowar :D
  def handle({:command, :armario, msg}, context) do
    chat_id = msg.chat.id
    prices_path = ExGram.Config.get(:acm_bot, :prices_file)

    case prices_path do
      path when path in ["", nil] ->
        answer(
          context,
          "Ups parece que no disponemos del pdf ahora mismo. Puedes molestar a alguien para que lo arregle :D"
        )

      _ ->
        case AcmBot.Cache.get(:file_id_comida) do
          nil ->
            {:ok, %{document: %{file_id: file_id}}} =
              ExGram.send_document(chat_id, {:file, prices_path})

            AcmBot.Cache.set(:file_id_comida, file_id)

          _ ->
            ExGram.send_document(chat_id, AcmBot.Cache.get(:file_id_comida))
        end
    end
  end

  def handle({:message, %{chat: %{id: cid}, new_chat_members: new_chat_members}}, _context) do
    Enum.each(new_chat_members, fn member ->
      user = Map.get(member, :username) || Map.get(member, :first_name)

      ExGram.send_message(
        cid,
        "Bienvenido a ACM #{user}!\nPuedes consultar todos nuestros grupos [aquí](https://discourse.acmupm.es/t/grupos-de-telegram/213)",
        parse_mode: "Markdown"
      )
    end)
  end

  def handle({:message, %{left_chat_member: left_chat_member}}, context) do
    user = Map.get(left_chat_member, :username) || Map.get(left_chat_member, :first_name)
    answer(context, "#dep, siempre saludaba\nTaluega #{user}!")
  end

  def handle(_, _) do
    :no_message_handle
  end

  # Private
  defp format_board_member(board_member) do
    """
    Alias: #{board_member["username"]}
    Rol: *#{board_member["role"]}*
    """
  end
end

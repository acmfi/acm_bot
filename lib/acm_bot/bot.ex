defmodule AcmBot.Bot do
  @bot :acm_bot

  use ExGram.Bot,
    name: @bot

  require Logger

  def bot(), do: @bot

  def handle({:command, "start", _message}, context) do
    answer(context, "Hola buenas tardes!\nEste es el nuevo bot de ACM.")
  end

  def handle({:message, %{chat: %{id: cid}, new_chat_members: new_chat_members}}, _context) do
    Enum.each(new_chat_members, fn member ->
      user = Map.get(member, :username) || Map.get(member, :first_name)
      ExGram.send_message(cid, "Bienvenido a ACM #{user}!")
    end)
  end

  def handle({:message, %{left_chat_member: left_chat_member}}, context) do
    user = Map.get(left_chat_member, :username) || Map.get(left_chat_member, :first_name)
    answer(context, "#dep, siempre saludaba\nTaluega #{user}!")
  end

  def handle(_, _) do
    :no_message_handle
  end
end

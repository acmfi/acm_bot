defmodule AcmBot.Bot do
  @bot :acm_bot

  use ExGram.Bot,
    name: @bot

  middleware(ExGram.Middleware.IgnoreUsername)

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

  # Versión precaria del comando armario. Es muy mejorable con las ideas de @IronJanoWar
  def handle({:command, "armario", msg}, context) do
    chat_id = msg.chat.id
    ExGram.send_document(chat_id, {:file, "../../precios.pdf"}) # La ruta se cambiará con la que corresponda dentro del servidor.
  end
  
  def handle(_, _) do
    :no_message_handle
  end
end

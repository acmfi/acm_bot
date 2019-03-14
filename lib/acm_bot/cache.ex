defmodule AcmBot.Cache do
  use GenServer
  require Logger

  # Client API
  def start_link(args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def set_file_id(id) do
    GenServer.cast(__MODULE__, {:set_file_id, id})
  end

  def get_file_id() do
    GenServer.call(__MODULE__, :get_file_id)
  end

  # Server Callbacks
  def init(:ok) do
    {:ok, ""}
  end

  def handle_cast({:set_file_id, id}, _state) do
    {:noreply, id}
  end

  def handle_call(:get_file_id, _from, state) do
    {:reply, state, state}
  end
end

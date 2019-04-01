defmodule AcmBot.Cache do
  use GenServer
  require Logger

  # Client API
  def start_link(args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def set(key, value) do
    GenServer.cast(__MODULE__, {:set, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # Server Callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:set, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
end

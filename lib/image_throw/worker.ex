defmodule ImageThrow.Worker do
  use GenServer
  require Logger

  #############################################################################
  #  Client functions
  #############################################################################
  def start_link(%{user_id: user_id} = opts) do
    Logger.info("Starting #{__MODULE__} for user #{user_id}")
    GenServer.start_link(__MODULE__, opts, name: via_tuple(opts))
  end

  def init(state) do
    {:ok, state, {:continue, :init}}
  end

  #############################################################################
  #  Server functions
  #############################################################################
  def handle_continue(:init, state) do
    {:noreply, state}
  end

  def via_tuple(name) do
    {:via, Registry, {ImageThrow.Registry, name}}
  end
end

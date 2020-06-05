defmodule ImageThrow.DynamicSupervisor do
  @moduledoc """
    Start child ImageThrow processes.
  """

  use DynamicSupervisor

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_child(module, opts) do
    spec = {module, opts}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end

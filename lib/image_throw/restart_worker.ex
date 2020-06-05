defmodule ImageThrow.RestartWorker do
  @moduledoc """
    Supervision tree trick to allow for each of the spawned workers to restart.
  """
  use GenServer
  alias ImageThrow.{DynamicSupervisor, Worker}

  #############################################################################
  #  Client functions
  #############################################################################
  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(state) do
    {:ok, state, {:continue, :init}}
  end

  #############################################################################
  #  Server functions
  #############################################################################
  def handle_continue(:init, state) do
    if Application.get_env(:image_throw, :env) != :test do
      DynamicSupervisor.start_child(Tortoise.Connection,
        client_id: Application.get_env(:image_throw, :mqtt_client_id),
        server: {
          Tortoise.Transport.SSL,
          cacertfile: :certifi.cacertfile(),
          host: "mqtt.lavatiles.com",
          port: 8884,
          versions: [:"tlsv1.2"],
          verify: :verify_none
        },
        handler: {Tortoise.Handler.Logger, []},
        user_name: Application.get_env(:image_throw, :mqtt_user),
        password: Application.get_env(:image_throw, :mqtt_pwd)
      )

      DynamicSupervisor.start_child(Worker, %{user_id: 1})
    end

    {:noreply, state}
  end
end

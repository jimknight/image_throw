defmodule ImageThrow.Supervisor do
  @moduledoc """
    Overall supervisor for ImageThrow
    * https://stackoverflow.com/questions/36792475/starting-dynamic-simple-one-for-one-workers-after-supervisor-starts
  """
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    children = [
      worker(Registry, [:unique, ImageThrow.Registry]),
      worker(ImageThrow.DynamicSupervisor, []),
      worker(ImageThrow.RestartWorker, [])
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end

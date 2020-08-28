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
    Process.send_after(self(), :get_latest_image, 1000)
    Process.send_after(self(), :delete_oldest_image, 1000)
    {:noreply, state}
  end

  def handle_info(:delete_oldest_image, state) do
    path = Application.get_env(:image_throw, :data_dir)
    Logger.info("Delete old images from #{path}")
    ImageThrow.delete_oldest_image(path)
    Process.send_after(self(), :delete_oldest_image, 1000)
    {:noreply, state}
  end

  def handle_info(:get_latest_image, state) do
    path = Application.get_env(:image_throw, :data_dir)
    Logger.info("Get latest image from #{path}")

    case ImageThrow.get_latest_image(path) do
      nil ->
        Logger.info("No images found from #{path}")
        Process.send_after(self(), :get_latest_image, 1000)

      image_path ->
        Logger.info("Send image #{image_path} to mqtt server")
        ImageThrow.push_image_to_mqtt_server(image_path, state.camera_id, state.user_id)
        Process.send_after(self(), :get_latest_image, 1000)
    end

    {:noreply, state}
  end

  def via_tuple(name) do
    {:via, Registry, {ImageThrow.Registry, name}}
  end
end

defmodule ImageThrow do
  require Logger
  alias ImageThrow.Mqtt

  def get_latest_image(path) do
    Path.wildcard("#{path}/*.jpg") |> Enum.at(-1)
  end

  def push_image_to_mqtt_server(image_path, camera_id, user_id) do
    case File.read(image_path) do
      {:ok, bin} ->
        client_id = Application.get_env(:image_throw, :mqtt_client_id)
        topic = "users/#{user_id}/camera/#{camera_id}/image"
        Mqtt.publish(client_id, topic, bin, retain: true)

      {:error, reason} ->
        Logger.error("Error reading #{image_path}: #{inspect(reason)}")
    end
  end
end

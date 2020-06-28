defmodule ImageThrow do
  require Logger
  alias ImageThrow.Mqtt

  def delete_old_images(path) do
    all_image_paths = Path.wildcard("#{path}/*.jpg")
    last_image = all_image_paths |> Enum.max()

    for image_path <- Enum.drop(all_image_paths, last_image) do
      File.rm!(image_path)
    end
  end

  def get_latest_image(path) do
    case Path.wildcard("#{path}/*.jpg") do
      nil -> nil
      [] -> nil
      image_paths -> image_paths |> Enum.max()
    end
  end

  def push_image_to_mqtt_server(image_path, camera_id, user_id) do
    case File.read(image_path) do
      {:ok, bin} ->
        client_id = Application.get_env(:image_throw, :mqtt_client_id)
        topic = "users/#{user_id}/camera/#{camera_id}/image"
        Mqtt.publish(client_id, topic, bin)

      {:error, reason} ->
        Logger.error("Error reading #{image_path}: #{inspect(reason)}")
    end
  end
end

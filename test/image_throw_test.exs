defmodule ImageThrowTest do
  use ExUnit.Case
  doctest ImageThrow

  test "delete_old_images(path)" do
    path = "/Users/jimknight/f/ffmpeg/images"
    ImageThrow.delete_old_images(path)
    [latest_image_path] = Path.wildcard("#{path}/*.jpg")
    refute latest_image_path == ""
  end

  test "get_latest_image" do
    path = "/Users/jimknight/f/ffmpeg/images"
    refute ImageThrow.get_latest_image(path) == nil
  end

  # test "push_image_to_mqtt_server(image_path,camera_id, user_id)" do
  #   image_path = "/Users/jimknight/f/ffmpeg/images/image-0015.jpg"
  #   assert ImageThrow.push_image_to_mqtt_server(image_path, "test", 1) == :ok
  # end
end

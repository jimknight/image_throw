defmodule ImageThrowTest do
  use ExUnit.Case
  doctest ImageThrow

  test "get_latest_image" do
    path = "/Users/jimknight/f/ffmpeg/images"
    refute ImageThrow.get_latest_image(path) == nil
  end

  test "push_image_to_mqtt_server(image_path,camera_id, user_id)" do
    image_path = "/Users/jimknight/f/ffmpeg/images/image-0015.jpg"
    assert ImageThrow.push_image_to_mqtt_server(image_path, "test", 1) == :ok
  end
end

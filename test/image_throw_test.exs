defmodule ImageThrowTest do
  use ExUnit.Case

  setup do
    path = Application.get_env(:image_throw, :data_dir)
    old_images = Path.wildcard("#{path}/*.jpg")

    for old_image <- old_images do
      File.rm(old_image)
    end

    :ok
  end

  # test "delete_old_images(path)" do
  #   path = Application.get_env(:image_throw, :data_dir)
  #   ImageThrow.delete_old_images(path)
  #   [latest_image_path] = Path.wildcard("#{path}/*.jpg")
  #   refute latest_image_path == ""
  # end
  #
  # test "get_latest_image" do
  #   path = Application.get_env(:image_throw, :data_dir)
  #   refute ImageThrow.get_latest_image(path) == nil
  # end

  describe "delete_oldest_image(path)" do
    test "if multiple" do
      path = Application.get_env(:image_throw, :data_dir)

      for counter <- 1..5 do
        File.touch("#{path}/#{Integer.to_string(counter)}.jpg")
      end

      ImageThrow.delete_oldest_image(path)
      images = Path.wildcard("#{path}/*.jpg")
      assert Enum.count(images) == 4
    end

    test "if only 1" do
      path = Application.get_env(:image_throw, :data_dir)
      old_images = Path.wildcard("#{path}/*.jpg")

      for old_image <- old_images do
        File.rm(old_image)
      end

      File.touch("#{path}/1.jpg")
      ImageThrow.delete_oldest_image(path)
      images = Path.wildcard("#{path}/*.jpg")
      assert Enum.count(images) == 1
    end
  end

  # test "push_image_to_mqtt_server(image_path,camera_id, user_id)" do
  #   image_path = "/Users/jimknight/f/ffmpeg/images/image-0015.jpg"
  #   assert ImageThrow.push_image_to_mqtt_server(image_path, "test", 1) == :ok
  # end
end

defmodule ImageThrow.Mqtt do
  require Logger

  def publish(client_id, topic, payload, options \\ []) do
    case Application.get_env(:image_throw, :env) do
      :test ->
        Logger.info("Skip publishing topic #{topic} to mqtt with payload #{payload} for TEST")

        :ok

      _ ->
        Logger.debug("Publish topic #{topic}")
        Tortoise.publish(client_id, topic, payload, options)
    end
  end
end

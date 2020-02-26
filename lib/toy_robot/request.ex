defmodule ToyRobot.Request do
  def get(endpoint) do
    api_base_url()
    |> Path.join(endpoint)
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
  end

  def post(endpoint, data \\ nil) do
    body =
      case data do
        nil -> ""
        %{} -> Jason.encode!(data)
      end

    api_base_url()
    |> Path.join(endpoint)
    |> HTTPoison.post!(
      body,
      [{"content-type", "application/json"}]
    )
    |> Map.get(:body)
    |> Jason.decode!()
  end

  defp api_base_url() do
    Application.get_env(:toy_robot, :api_base_url)
  end
end

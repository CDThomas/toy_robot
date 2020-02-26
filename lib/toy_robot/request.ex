defmodule ToyRobot.Request do
  def get(endpoint) do
    path = Path.join(api_base_url(), endpoint)

    with {:ok, resp} <- HTTPoison.get(path),
         body = Map.get(resp, :body),
         {:ok, data} <- Jason.decode(body) do
      {:ok, data}
    end
  end

  def post(endpoint, data \\ nil) do
    path = Path.join(api_base_url(), endpoint)

    body =
      case data do
        nil -> ""
        %{} -> Jason.encode!(data)
      end

    opts = [{"content-type", "application/json"}]

    with {:ok, resp} <- HTTPoison.post(path, body, opts),
         body = Map.get(resp, :body),
         {:ok, data} <- Jason.decode(body) do
      {:ok, data}
    end
  end

  defp api_base_url() do
    Application.get_env(:toy_robot, :api_base_url)
  end
end

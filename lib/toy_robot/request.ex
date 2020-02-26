defmodule ToyRobot.Request do
  @type return_value :: {:ok, map() | nil} | {:error, HTTPoison.Error.t() | Jason.DecodeError.t()}

  @moduledoc """
  Functions for making requests to the ToyRobot HTTP server.
  """

  @doc """
  Makes a GET request to the ToyRobot HTTP server.

  Returns the JSON decoded response body.

  Returns an error in the request fails.
  """
  @spec get(endpoint :: binary()) :: return_value()
  def get(endpoint) do
    path = Path.join(api_base_url(), endpoint)

    with {:ok, resp} <- HTTPoison.get(path),
         body = Map.get(resp, :body),
         {:ok, data} <- Jason.decode(body) do
      {:ok, data}
    end
  end

  @doc """
  Makes a POST request to the ToyRobot HTTP server.

  Returns the JSON decoded response body.

  Returns an error in the request fails.
  """
  @spec post(endpoint :: binary(), data :: map() | nil) :: return_value()
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

defmodule Mix.Tasks.Repl do
  alias ToyRobot.Parser
  alias ToyRobot.Runner

  def run(_) do
    {:ok, _} = Application.ensure_all_started(:httpoison)
    read()
  end

  def read() do
    case IO.read(:stdio, :line) do
      :eof ->
        :ok

      {:error, message} ->
        IO.puts("Error: #{message}")

      line ->
        with {:ok, command} <- Parser.parse(line),
             {:ok, state} <- Runner.run(command) do
          maybe_print(state)
        else
          error -> IO.inspect(error, label: "Error")
        end

        read()
    end
  end

  defp maybe_print(nil) do
    :noop
  end

  defp maybe_print(state) do
    state
    |> format()
    |> IO.puts()
  end

  defp format(%{"x" => x, "y" => y, "direction" => direction}) do
    formatted_direction = String.upcase(direction)
    "(#{x}, #{y}, #{formatted_direction})"
  end
end

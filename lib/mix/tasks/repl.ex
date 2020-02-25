defmodule Mix.Tasks.Repl do
  alias ToyRobot.Parser
  alias ToyRobot.Runner

  def run(_) do
    read()
  end

  def read(state \\ nil) do
    case IO.read(:stdio, :line) do
      :eof ->
        :ok

      {:error, message} ->
        IO.puts("Error: #{message}")

      line ->
        state =
          case Parser.parse(line) do
            {:ok, command} ->
              Runner.run(command, state)

            {:error, error} ->
              IO.inspect(error, label: "Error")
              state
          end

        maybe_print(state)
        read(state)
    end
  end

  defp maybe_print(%ToyRobot{} = state) do
    state
    |> format()
    |> IO.puts()
  end

  defp maybe_print(nil) do
    :noop
  end

  defp format(%ToyRobot{x: x, y: y, direction: direction}) do
    formatted_direction =
      direction
      |> Atom.to_string()
      |> String.upcase()

    "(#{x}, #{y}, #{formatted_direction})"
  end
end

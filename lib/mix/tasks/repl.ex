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
              Runner.run(command) |> IO.inspect()

            {:error, error} ->
              IO.inspect(error, label: "Error")
              state
          end

        read(state)
    end
  end
end

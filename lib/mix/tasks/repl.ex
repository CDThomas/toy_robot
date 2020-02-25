defmodule Mix.Tasks.Repl do
  alias ToyRobot.Parser
  alias ToyRobot.Runner

  def run(_) do
    read()
  end

  def read(_state \\ %ToyRobot{}) do
    case IO.read(:stdio, :line) do
      :eof ->
        :ok

      {:error, message} ->
        IO.puts("Error: #{message}")

      line ->
        state =
          with {:ok, command} <- Parser.parse(line) do
            Runner.run(command) |> IO.inspect()
          else
            {:error, error} -> IO.inspect(error, label: "Error")
          end

        read(state)
    end
  end
end

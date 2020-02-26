defmodule ToyRobot.Parser do
  @type parser_error ::
          {:error, :invalid_args | :invalid_command | :invalid_coordinate | :invalid_direction}

  @doc """
  parses command strings into commands for the ToyRobot.Runner to run.

  Valid commands are:
  "PLACE X,Y,F"
  "MOVE"
  "LEFT"
  "RIGHT"
  "REPORT"

  Leading and trailing whitespace is trimmed.

  For the PLACE command, spaces and commas (",") between args are ignored.
  """
  @spec parse(command :: binary()) :: {:ok, ToyRobot.Runner.command()} | parser_error()
  def parse(command) do
    command
    |> String.trim()
    |> String.split([" ", ","], trim: true)
    |> do_parse()
  end

  defp do_parse(["PLACE" | args]) do
    with {:ok, [x, y, direction]} <- parse_args(args) do
      {:ok, {:place, x, y, direction}}
    end
  end

  defp do_parse(["REPORT"]) do
    {:ok, :report}
  end

  defp do_parse(["MOVE"]) do
    {:ok, :move}
  end

  defp do_parse(["RIGHT"]) do
    {:ok, :right}
  end

  defp do_parse(["LEFT"]) do
    {:ok, :left}
  end

  defp do_parse(_) do
    {:error, :invalid_command}
  end

  defp parse_args([x, y, f]) do
    with {:ok, x} <- parse_coordinate(x),
         {:ok, y} <- parse_coordinate(y),
         {:ok, direction} <- parse_direction(f) do
      {:ok, [x, y, direction]}
    end
  end

  defp parse_args(_) do
    {:error, :invalid_args}
  end

  defp parse_coordinate(n) do
    case Integer.parse(n) do
      {n, _} when n >= 0 -> {:ok, n}
      _ -> {:error, :invalid_coordinate}
    end
  end

  defp parse_direction(direction) when direction in ["NORTH", "EAST", "SOUTH", "WEST"] do
    # N.B. the direction is validated by the guard clause above, so the call to String.to_atom/1 is safe here.
    parsed_direction =
      direction
      |> String.downcase()
      |> String.to_atom()

    {:ok, parsed_direction}
  end

  defp parse_direction(_) do
    {:error, :invalid_direction}
  end
end

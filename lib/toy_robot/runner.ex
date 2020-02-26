defmodule ToyRobot.Runner do
  alias ToyRobot.Request

  @type place_command ::
          {:place, ToyRobot.coordinate(), ToyRobot.coordinate(), ToyRobot.direction()}
  @type command :: place_command() | :report | :move | :right | :left

  @doc """
  Takes an internal representation of a command from ToyRobot.Parser.parse/1 and runs the corresponding command with the current state.
  """
  @spec run(command :: command()) :: Request.return_value()
  def run({:place, x, y, direction}) do
    Request.post("/place", %{x: x, y: y, direction: direction})
  end

  def run(:report) do
    Request.get("/report")
  end

  def run(:move) do
    Request.post("/move")
  end

  def run(:right) do
    Request.post("/right")
  end

  def run(:left) do
    Request.post("/left")
  end
end

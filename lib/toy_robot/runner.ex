defmodule ToyRobot.Runner do
  @type place_command ::
          {:place, ToyRobot.coordinate(), ToyRobot.coordinate(), ToyRobot.direction()}
  @type command :: place_command() | :report | :move | :right | :left

  @doc """
  Takes an internal representation of a command from ToyRobot.Parser.parse/1 and runs the corresponding command with the current state.
  """
  @spec run(command :: command(), state :: ToyRobot.t() | nil) :: ToyRobot.t() | nil
  def run({:place, x, y, direction}, _) do
    ToyRobot.place(x, y, direction)
  end

  def run(_, nil) do
    nil
  end

  def run(:report, state) do
    ToyRobot.report(state)
  end

  def run(:move, state) do
    ToyRobot.move(state)
  end

  def run(:right, state) do
    ToyRobot.right(state)
  end

  def run(:left, state) do
    ToyRobot.left(state)
  end
end

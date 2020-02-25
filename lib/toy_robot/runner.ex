defmodule ToyRobot.Runner do
  @type place_command ::
          {:place, ToyRobot.coordinate(), ToyRobot.coordinate(), ToyRobot.direction()}
  @type command :: place_command()

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
end

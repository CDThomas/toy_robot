defmodule ToyRobot.Runner do
  @type place_command ::
          {:place, ToyRobot.coordinate(), ToyRobot.coordinate(), ToyRobot.direction()}
  @type command :: place_command()

  @spec run(command :: command()) :: ToyRobot.t()
  def run({:place, x, y, direction}) do
    ToyRobot.place(x, y, direction)
  end
end

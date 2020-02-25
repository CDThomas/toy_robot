defmodule ToyRobot.RunnerTest do
  use ExUnit.Case

  alias ToyRobot.Runner

  test "Runs place commands" do
    command = {:place, 0, 0, :south}
    assert Runner.run(command) == %ToyRobot{x: 0, y: 0, direction: :south}
  end
end

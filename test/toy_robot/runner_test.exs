defmodule ToyRobot.RunnerTest do
  use ExUnit.Case

  alias ToyRobot.Runner

  test "runs place commands" do
    command = {:place, 0, 0, :south}
    assert Runner.run(command, nil) == %ToyRobot{x: 0, y: 0, direction: :south}
  end

  test "runs report commands" do
    state = %ToyRobot{x: 0, y: 0, direction: :north}
    assert Runner.run(:report, state) == state
  end

  test "runs report command given nil state" do
    assert Runner.run(:report, nil) == nil
  end

  test "runs move commands" do
    initial_state = %ToyRobot{x: 0, y: 0, direction: :north}
    expected_state = %ToyRobot{x: 0, y: 1, direction: :north}

    assert Runner.run(:move, initial_state) == expected_state
  end
end

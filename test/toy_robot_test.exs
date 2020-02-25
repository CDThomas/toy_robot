defmodule ToyRobotTest do
  use ExUnit.Case

  describe "place/3" do
    test "returns a ToyRobot with default values when called with no args" do
      assert ToyRobot.place() == %ToyRobot{x: 0, y: 0, direction: :north}
    end

    test "returns a ToyRobot with the correct values when called with args" do
      assert ToyRobot.place(1, 2, :east) == %ToyRobot{x: 1, y: 2, direction: :east}
    end
  end

  describe "report/1" do
    test "passes through the robot" do
      robot = %ToyRobot{x: 1, y: 1, direction: :east}
      assert ToyRobot.report(robot) == robot
    end

    test "passes through nil given nil" do
      assert ToyRobot.report(nil) == nil
    end
  end
end

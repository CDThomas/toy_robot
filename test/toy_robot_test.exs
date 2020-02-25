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

  describe "move/1" do
    test "increments y by one when facing north" do
      initial_robot = %ToyRobot{x: 0, y: 0, direction: :north}
      expected_robot = %ToyRobot{x: 0, y: 1, direction: :north}

      assert ToyRobot.move(initial_robot) == expected_robot
    end

    test "decrememnts y by one when facing south" do
      initial_robot = %ToyRobot{x: 0, y: 4, direction: :south}
      expected_robot = %ToyRobot{x: 0, y: 3, direction: :south}

      assert ToyRobot.move(initial_robot) == expected_robot
    end

    test "increments x by one when facing east" do
      initial_robot = %ToyRobot{x: 0, y: 0, direction: :east}
      expected_robot = %ToyRobot{x: 1, y: 0, direction: :east}

      assert ToyRobot.move(initial_robot) == expected_robot
    end

    test "decrements x by one when facing west" do
      initial_robot = %ToyRobot{x: 1, y: 0, direction: :west}
      expected_robot = %ToyRobot{x: 0, y: 0, direction: :west}

      assert ToyRobot.move(initial_robot) == expected_robot
    end

    test "ignores the command if out of space when facing north" do
      initial_robot = %ToyRobot{x: 0, y: 4, direction: :north}
      expected_robot = %ToyRobot{x: 0, y: 4, direction: :north}

      assert ToyRobot.move(initial_robot) == expected_robot
    end

    test "ignores the command if out of space when facing south" do
      initial_robot = %ToyRobot{x: 0, y: 0, direction: :south}
      expected_robot = %ToyRobot{x: 0, y: 0, direction: :south}

      assert ToyRobot.move(initial_robot) == expected_robot
    end

    test "ignores the command if out of space when facing east" do
      initial_robot = %ToyRobot{x: 4, y: 0, direction: :east}
      expected_robot = %ToyRobot{x: 4, y: 0, direction: :east}

      assert ToyRobot.move(initial_robot) == expected_robot
    end

    test "ignores the command if out of space when facing west" do
      initial_robot = %ToyRobot{x: 0, y: 0, direction: :west}
      expected_robot = %ToyRobot{x: 0, y: 0, direction: :west}

      assert ToyRobot.move(initial_robot) == expected_robot
    end
  end
end

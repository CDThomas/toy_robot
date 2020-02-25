defmodule ToyRobot.ParserTest do
  use ExUnit.Case

  alias ToyRobot.Parser

  describe "parsing the PLACE command" do
    test "returns the correct MFA given the direction SOUTH" do
      command = "PLACE 0,0,SOUTH"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [0, 0, :south]}}
    end

    test "returns the correct MFA given the direction NORTH" do
      command = "PLACE 0,0,NORTH"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [0, 0, :north]}}
    end

    test "returns the correct MFA given the direction EAST" do
      command = "PLACE 0,0,EAST"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [0, 0, :east]}}
    end

    test "returns the correct MFA given the direction WEST" do
      command = "PLACE 0,0,WEST"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [0, 0, :west]}}
    end

    test "returns the correct MFA when X is 0" do
      command = "PLACE 0,0,SOUTH"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [0, 0, :south]}}
    end

    test "returns the correct MFA when X is greater than 0" do
      command = "PLACE 8,0,SOUTH"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [8, 0, :south]}}
    end

    test "returns the correct MFA when Y is 0" do
      command = "PLACE 0,0,SOUTH"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [0, 0, :south]}}
    end

    test "returns the correct MFA when Y is greater than 0" do
      command = "PLACE 0,6,SOUTH"
      assert Parser.parse(command) == {:ok, {ToyRobot, :place, [0, 6, :south]}}
    end

    test "returns an error given an invalid direction" do
      command = "PLACE 0,0,NOPE"
      assert Parser.parse(command) == {:error, :invalid_direction}
    end

    test "returns an error given an invalid value for X" do
      command = "PLACE -5,0,SOUTH"
      assert Parser.parse(command) == {:error, :invalid_coordinate}
    end

    test "returns an error given an invalid value for Y" do
      command = "PLACE 0,-2,SOUTH"
      assert Parser.parse(command) == {:error, :invalid_coordinate}
    end

    test "returns an error given no args" do
      command = "PLACE"
      assert Parser.parse(command) == {:error, :invalid_args}
    end
  end
end

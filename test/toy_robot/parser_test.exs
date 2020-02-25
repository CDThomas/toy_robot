defmodule ToyRobot.ParserTest do
  use ExUnit.Case

  alias ToyRobot.Parser

  describe "parsing the PLACE command" do
    test "returns the correct command name" do
      command = "PLACE 0,0,SOUTH"
      assert {:ok, {:place, _, _, _}} = Parser.parse(command)
    end

    test "returns the correct direction given SOUTH" do
      command = "PLACE 0,0,SOUTH"
      assert {:ok, {_, _, _, :south}} = Parser.parse(command)
    end

    test "returns the correct direction given NORTH" do
      command = "PLACE 0,0,NORTH"
      assert {:ok, {_, _, _, :north}} = Parser.parse(command)
    end

    test "returns the correct direction given EAST" do
      command = "PLACE 0,0,EAST"
      assert {:ok, {_, _, _, :east}} = Parser.parse(command)
    end

    test "returns the correct direction given WEST" do
      command = "PLACE 0,0,WEST"
      assert {:ok, {_, _, _, :west}} = Parser.parse(command)
    end

    test "returns the correct value for X given 0" do
      command = "PLACE 0,0,SOUTH"
      assert {:ok, {_, 0, _, _}} = Parser.parse(command)
    end

    test "returns the correct value for X given a positive integer" do
      command = "PLACE 8,0,SOUTH"
      assert {:ok, {_, 8, _, _}} = Parser.parse(command)
    end

    test "returns the correct value for Y given 0" do
      command = "PLACE 0,0,SOUTH"
      assert {:ok, {_, _, 0, _}} = Parser.parse(command)
    end

    test "returns the correct value for Y given a positive integer" do
      command = "PLACE 0,6,SOUTH"
      assert {:ok, {_, _, 6, _}} = Parser.parse(command)
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

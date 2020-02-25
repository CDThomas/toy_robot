defmodule Mix.Tasks.ReplTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias Mix.Tasks.Repl

  test "Prints the correct output given a place command" do
    assert capture_io("PLACE 0,0,SOUTH\n", fn ->
             Repl.run([])
           end) == "(0, 0, SOUTH)\n"
  end

  test "Ignores commands until the robot is placed" do
    commands = """
    REPORT
    MOVE
    RIGHT
    LEFT
    """

    assert capture_io(commands, fn ->
             Repl.run([])
           end) == ""
  end

  test "Handles multiple commands" do
    commands = """
    PLACE 0,0,NORTH
    REPORT
    MOVE
    RIGHT
    LEFT
    """

    expected =
      [
        "(0, 0, NORTH)",
        "(0, 0, NORTH)",
        "(0, 1, NORTH)",
        "(0, 1, EAST)",
        "(0, 1, NORTH)"
      ]
      |> Enum.join("\n")

    assert capture_io(commands, fn ->
             Repl.run([])
           end) == expected <> "\n"
  end
end

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
    assert capture_io("REPORT\nMOVE\n", fn ->
             Repl.run([])
           end) == ""
  end

  test "Handles multiple commands" do
    assert capture_io("PLACE 0,0,NORTH\nREPORT\nMOVE\n", fn ->
             Repl.run([])
           end) == "(0, 0, NORTH)\n(0, 0, NORTH)\n(0, 1, NORTH)\n"
  end
end

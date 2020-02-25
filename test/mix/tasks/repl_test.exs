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
    assert capture_io("REPORT\n", fn ->
             Repl.run([])
           end) == ""
  end

  test "Handles multiple commands" do
    assert capture_io("PLACE 0,0,SOUTH\nREPORT\n", fn ->
             Repl.run([])
           end) == "(0, 0, SOUTH)\n(0, 0, SOUTH)\n"
  end
end

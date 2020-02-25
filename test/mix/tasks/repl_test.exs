defmodule Mix.Tasks.ReplTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias Mix.Tasks.Repl

  test "Prints the correct output given a place command" do
    assert capture_io("PLACE 0,0,SOUTH\n", fn ->
             Repl.run([])
           end) == "(0, 0, SOUTH)\n"
  end
end

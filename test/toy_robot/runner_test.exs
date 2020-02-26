defmodule ToyRobot.RunnerTest do
  use ExUnit.Case

  import Mock

  alias ToyRobot.Request
  alias ToyRobot.Runner

  test "makes a POST request to /place given a place command" do
    with_mock Request, post: fn _, _ -> :ok end do
      Runner.run({:place, 0, 0, :south})
      assert_called(Request.post("/place", %{x: 0, y: 0, direction: :south}))
    end
  end

  test "makes a request to GET /report given a report command" do
    with_mock Request, get: fn _ -> :ok end do
      Runner.run(:report)
      assert_called(Request.get("/report"))
    end
  end

  test "makes a request to POST /move given a move command" do
    with_mock Request, post: fn _ -> :ok end do
      Runner.run(:move)
      assert_called(Request.post("/move"))
    end
  end

  test "makes a request to POST /right given a right command" do
    with_mock Request, post: fn _ -> :ok end do
      Runner.run(:right)
      assert_called(Request.post("/right"))
    end
  end

  test "makes a request to POST /left given a left command" do
    with_mock Request, post: fn _ -> :ok end do
      Runner.run(:left)
      assert_called(Request.post("/left"))
    end
  end
end

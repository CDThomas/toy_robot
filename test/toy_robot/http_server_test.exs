defmodule ToyRobot.HttpServerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ToyRobot.HttpServer
  alias ToyRobot.State

  @opts HttpServer.init([])

  setup do
    on_exit(fn ->
      State.update(nil)
    end)
  end

  describe "GET /report" do
    test "returns nil when state is empty" do
      conn =
        :get
        |> conn("/report")
        |> HttpServer.call(@opts)

      assert json_response(conn) == nil
    end
  end

  describe "POST /place" do
    test "places the robot and returns the state" do
      conn =
        :post
        |> conn("/place", %{x: 0, y: 0, direction: :north})
        |> HttpServer.call(@opts)

      assert json_response(conn) == %{"x" => 0, "y" => 0, "direction" => "north"}
    end
  end

  describe "POST /move" do
    test "movese the robot and returns the state" do
      State.update(ToyRobot.place())

      conn =
        :post
        |> conn("/move", "")
        |> HttpServer.call(@opts)

      assert json_response(conn) == %{"x" => 0, "y" => 1, "direction" => "north"}
    end
  end

  defp json_response(conn) do
    assert conn.state == :sent
    assert conn.status == 200
    assert get_resp_header(conn, "content-type") == ["application/json; charset=utf-8"]

    Jason.decode!(conn.resp_body)
  end
end

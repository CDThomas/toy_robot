defmodule ToyRobot.HttpServerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ToyRobot.HttpServer

  @opts HttpServer.init([])

  describe "GET /report" do
    test "returns hello world" do
      conn =
        :get
        |> conn("/report")
        |> HttpServer.call(@opts)

      assert json_response(conn) == nil
    end
  end

  defp json_response(conn) do
    assert conn.state == :sent
    assert conn.status == 200
    assert get_resp_header(conn, "content-type") == ["application/json; charset=utf-8"]

    Jason.decode!(conn.resp_body)
  end
end

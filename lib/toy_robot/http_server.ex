defmodule ToyRobot.HttpServer do
  use Plug.Router

  import Plug.Conn

  require Protocol

  alias ToyRobot.State

  Protocol.derive(Jason.Encoder, ToyRobot)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/report" do
    json(conn, State.get())
  end

  post "/place" do
    # TODO: validate params
    %{"x" => x, "y" => y, "direction" => direction} = conn.body_params

    State.update(ToyRobot.place(x, y, direction))

    json(conn, State.get())
  end

  post "/move" do
    do_if_placed(&ToyRobot.move/1)
    json(conn, State.get())
  end

  post "/right" do
    do_if_placed(&ToyRobot.right/1)
    json(conn, State.get())
  end

  post "/left" do
    do_if_placed(&ToyRobot.left/1)
    json(conn, State.get())
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

  defp json(conn, resp_body) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(resp_body))
  end

  defp do_if_placed(func) do
    State.get()
    |> case do
      nil ->
        :noop

      %ToyRobot{} = robot ->
        robot
        |> func.()
        |> State.update()
    end
  end
end

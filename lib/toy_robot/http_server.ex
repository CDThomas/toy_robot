defmodule ToyRobot.HttpServer do
  use Plug.Router

  import Plug.Conn

  require Protocol

  alias ToyRobot.State

  Protocol.derive(Jason.Encoder, ToyRobot)

  if Mix.env() == :dev do
    use Plug.Debugger
  end

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
    if valid?(conn.body_params) do
      %{"x" => x, "y" => y, "direction" => direction} = conn.body_params
      robot = ToyRobot.place(x, y, String.to_atom(direction))
      state = State.get_and_update(robot)

      json(conn, state)
    else
      send_resp(conn, 400, "Bad Request")
    end
  end

  post "/move" do
    state = do_if_placed(&ToyRobot.move/1)
    json(conn, state)
  end

  post "/right" do
    state = do_if_placed(&ToyRobot.right/1)
    json(conn, state)
  end

  post "/left" do
    state = do_if_placed(&ToyRobot.left/1)
    json(conn, state)
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
        nil

      %ToyRobot{} = robot ->
        robot
        |> func.()
        |> State.get_and_update()
    end
  end

  defp valid?(params) do
    is_integer(params["x"]) and is_integer(params["y"]) and
      params["direction"] in ["north", "east", "south", "west"]
  end
end

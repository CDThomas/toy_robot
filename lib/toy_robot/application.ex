defmodule ToyRobot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: ToyRobot.HttpServer, options: [port: 4001]},
      {ToyRobot.State, nil}
    ]

    opts = [strategy: :one_for_one, name: ToyRobot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

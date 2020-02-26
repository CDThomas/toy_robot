defmodule ToyRobot.MixProject do
  use Mix.Project

  def project do
    [
      app: :toy_robot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ToyRobot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.1"},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:mock, "~> 0.3.0", only: :test},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end

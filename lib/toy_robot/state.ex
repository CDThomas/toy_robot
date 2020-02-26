defmodule ToyRobot.State do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def update(robot) do
    Agent.update(__MODULE__, fn _ -> robot end)
  end
end
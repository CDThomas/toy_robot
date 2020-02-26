defmodule ToyRobot.State do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def update do
    Agent.update(__MODULE__, & &1)
  end
end

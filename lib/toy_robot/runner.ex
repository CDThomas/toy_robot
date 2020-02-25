defmodule ToyRobot.Runner do
  def run({module, function, attribute}) do
    apply(module, function, attribute)
  end
end

defmodule ToyRobot do
  @moduledoc """
  ToyRobot.
  """

  defstruct [:x, :y, :direction]

  @type t :: %__MODULE__{
          x: coordinate() | nil,
          y: coordinate() | nil,
          direction: direction() | nil
        }

  @type coordinate :: 0..4
  @type direction :: :north | :east | :south | :west

  @doc """
  Places the toy robot on the table in position x, y and with the direction :north, :south, :east, or :west.
  """
  @spec place(x :: 0..4, y :: 0..4, direction :: direction()) :: t()
  def place(x \\ 0, y \\ 0, direction \\ :north) do
    %__MODULE__{x: x, y: y, direction: direction}
  end
end

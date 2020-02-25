defmodule ToyRobot do
  @moduledoc """
  Functions for simulating a toy robot moving on a square tabletop.

  The table top has dimensions of 5 units x 5 units. There are no other obstructions on the table surface.

  Any movement that would result in the robot falling from the table is prevented, however further valid movement
  commands are still allowed.
  """

  defstruct [:x, :y, :direction]

  @type t :: %__MODULE__{
          x: coordinate() | nil,
          y: coordinate() | nil,
          direction: direction() | nil
        }

  @type coordinate :: 0..4
  @type direction :: :north | :east | :south | :west

  @table_size 4

  @doc """
  Places the toy robot on the table in position x, y and with the direction :north, :south, :east, or :west.
  """
  @spec place(x :: 0..4, y :: 0..4, direction :: direction()) :: t()
  def place(x \\ 0, y \\ 0, direction \\ :north) do
    %__MODULE__{x: x, y: y, direction: direction}
  end

  @doc """
  Passes through the given robot. Returns nil when given nil.
  """
  @spec report(robot :: ToyRobot.t()) :: ToyRobot.t()
  def report(%ToyRobot{} = robot), do: robot

  @doc """
  Moves the toy robot one unit forward in the direction it is currently facing.

  Ignore the command if movement would cause the robot to fall off the table.
  """
  @spec move(robot :: ToyRobot.t()) :: ToyRobot.t()
  def move(%ToyRobot{direction: :north, y: y} = robot) when y < @table_size do
    %{robot | y: y + 1}
  end

  def move(%ToyRobot{direction: :south, y: y} = robot) when y > 0 do
    %{robot | y: y - 1}
  end

  def move(%ToyRobot{direction: :east, x: x} = robot) when x < @table_size do
    %{robot | x: x + 1}
  end

  def move(%ToyRobot{direction: :west, x: x} = robot) when x > 0 do
    %{robot | x: x - 1}
  end

  def move(%ToyRobot{} = robot) do
    robot
  end

  @doc """
  Rotates the robot 90 degrees to the right. Does not change the position of the robot.
  """
  @spec right(robot :: ToyRobot.t()) :: ToyRobot.t()
  def right(%ToyRobot{direction: :north} = robot) do
    %{robot | direction: :east}
  end

  def right(%ToyRobot{direction: :east} = robot) do
    %{robot | direction: :south}
  end

  def right(%ToyRobot{direction: :south} = robot) do
    %{robot | direction: :west}
  end

  def right(%ToyRobot{direction: :west} = robot) do
    %{robot | direction: :north}
  end

  @doc """
  Rotates the robot 90 degrees to the left. Does not change the position of the robot.
  """
  @spec left(robot :: ToyRobot.t()) :: ToyRobot.t()
  def left(%ToyRobot{direction: :north} = robot) do
    %{robot | direction: :west}
  end

  def left(%ToyRobot{direction: :west} = robot) do
    %{robot | direction: :south}
  end

  def left(%ToyRobot{direction: :south} = robot) do
    %{robot | direction: :east}
  end

  def left(%ToyRobot{direction: :east} = robot) do
    %{robot | direction: :north}
  end
end

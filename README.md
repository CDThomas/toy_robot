# Toy Robot Simulator

## Description

The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
There are no other obstructions on the table surface. The robot is free to roam around the surface of the table.
Any movement that would result in the robot falling from the table is prevented, however further valid movement
commands are still allowed.

Create an application that can read in commands of the following form:

PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT

## Rules

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) is the SOUTH WEST most corner.
- The position is reported as a triplet (X, Y, DIRECTION)
- The initial position is (nil, nil, nil)
- All commands are ignored until a PLACE command is received and the robot is placed in a position.
- REPORT prints / returns the position in a triplet.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- PLACE, MOVE, LEFT and RIGHT will print / return the position after command is executed.

## Interaction

- Implement a REPL to enter the commands and see the results. If the input is not a TTY, read input from STDIN and print results to STDOUT.
- Extend this implentation to allow mutiple users to control a single toy robot at the same time.
  - You can do this with something as simple as a TCP Server than receives inputs and sends the output back to client
  - Or any approach you see fit to allow multiple users to control the robot.

## Deliverables

- A git repository with
  - source code.
  - tests.
- Use small functional commits.
- Documentation of any specific design choices.

## Timeframes

- No fixed timeframe, submit the solution when you're happy with it.

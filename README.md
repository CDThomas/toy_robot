# Toy Robot Simulator

## Usage

First, install deps and compile the app:
```
mix deps.get
mix compile
```

Then, start the HTTP server (there shouldn't be output on start):
```
mix http_server
```

In another terminal, start the REPL (there shouldn't be output on start):
```
mix repl
```

From there, issue commands via the REPL (described in more detail below):
```
PLACE 0,0,NORTH
MOVE
RIGHT
REPORT
MOVE
```

To exit the REPL, hit ctrl + D.

Commands are also accepted via STDIN:
```
echo "PLACE 0,0,NORTH" | mix repl
```

## Testing

Run tests with:
```
mix test
```

Tests can also run in watch mode:
```
mix test.watch
```

To run the type checker:
```
mix dialyzer
```

Note: tests for the REPL act as integration tests and make network calls against the HTTP server.

## Design

There are two main parts to the application.

The first is the REPL. It takes commands, parses them, and makes requests to the HTTP server.

The second main part of the application is the HTTP server. It accepts requests from the REPL and maintains game state.

For more details, see the docs for individual modules and functions.

## Specification

### Description

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

### Rules

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) is the SOUTH WEST most corner.
- The position is reported as a triplet (X, Y, DIRECTION)
- The initial position is (nil, nil, nil)
- All commands are ignored until a PLACE command is received and the robot is placed in a position.
- REPORT prints / returns the position in a triplet.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- PLACE, MOVE, LEFT and RIGHT will print / return the position after command is executed.

### Interaction

- Implement a REPL to enter the commands and see the results. If the input is not a TTY, read input from STDIN and print results to STDOUT.
- Extend this implentation to allow mutiple users to control a single toy robot at the same time.
  - You can do this with something as simple as a TCP Server than receives inputs and sends the output back to client
  - Or any approach you see fit to allow multiple users to control the robot.

### Deliverables

- A git repository with
  - source code.
  - tests.
- Use small functional commits.
- Documentation of any specific design choices.


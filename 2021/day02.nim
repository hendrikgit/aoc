import sequtils, strscans, strutils

let example = """
forward 5
down 5
forward 8
up 3
down 8
forward 2""".splitLines

let input = "input02.txt".lines.toSeq

type
  Position = tuple
    x, y: int

func position(commands: seq[string]): Position =
  for command in commands:
    let (match, direction, value) = command.scanTuple("$w $i$.")
    if match:
      case direction
      of "forward":
        result.x += value
      of "down":
        result.y += value
      of "up":
        result.y -= value

func positionTwo(commands: seq[string]): Position =
  var aim = 0
  for command in commands:
    let (match, direction, value) = command.scanTuple("$w $i$.")
    if match:
      case direction
      of "forward":
        result.x += value
        result.y += aim * value
      of "down":
        aim += value
      of "up":
        aim -= value

func multiply(pos: Position): int =
  pos.x * pos.y

echo "Example one: ", example.position.multiply
echo "Part one: ", input.position.multiply
echo "Example two: ", example.positionTwo.multiply
echo "Part two: ", input.positionTwo.multiply

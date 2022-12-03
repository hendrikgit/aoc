import sequtils, strscans, strutils, tables

const example = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2""".splitLines

let input = "input05.txt".lines.toSeq

type
  Line = tuple[x1, y1, x2, y2: int]
  Position = tuple[x, y: int]

func parseLines(input: seq[string]): seq[Line] =
  for line in input:
    let (match, x1, y1, x2, y2) = line.scanTuple("$i,$i -> $i,$i")
    if match:
      result.add (x1, y1, x2, y2)

iterator count(a, b: int): int =
  if a <= b:
    for i in countup(a, b):
      yield i
  else:
    for i in countdown(a, b):
      yield i

func positions(lines: seq[Line], diagonal = false): CountTable[Position] =
  for line in lines:
    if line.x1 == line.x2:
      for y in count(line.y1, line.y2):
        result.inc (line.x1, y)
    elif line.y1 == line.y2:
      for x in count(line.x1, line.x2):
        result.inc (x, line.y1)
    elif diagonal:
      assert abs(line.x1 - line.x2) == abs(line.y1 - line.y2)
      var positions: seq[Position]
      for x in count(line.x1, line.x2):
        positions.add (x, -1)
      var idx = 0
      for y in count(line.y1, line.y2):
        positions[idx].y = y
        inc idx
      for position in positions:
        result.inc position

func countOverlaps(positions: CountTable[Position], min = 2): int =
  positions.values.toSeq.filterIt(it >= min).len

echo "Example one: ", example.parseLines.positions.countOverlaps
echo "Part one: ", input.parseLines.positions.countOverlaps
echo "Example two: ", example.parseLines.positions(diagonal = true).countOverlaps
echo "Part two: ", input.parseLines.positions(diagonal = true).countOverlaps

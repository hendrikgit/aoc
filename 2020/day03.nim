import sequtils, strutils

let exampleInput = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#""".splitLines

let input = "input03.txt".lines.toSeq

type
  Position = tuple[x: int, y: int]
  Slope = tuple[right: int, down: int]

func positions(map: seq[string], slope: Slope): seq[Position] =
  let height = map.len
  let width = map[0].len
  var pos: Position = (slope.right mod width, slope.down)
  while pos.y < height:
    result.add pos
    pos.x = (pos.x + slope.right) mod width
    pos.y += slope.down

func treeCount(map: seq[string], slope: Slope): int =
  for pos in map.positions(slope):
    if map[pos.y][pos.x] == '#':
      inc result

echo "Example one: ", exampleInput.treeCount((right: 3, down: 1))
echo "Part one: ", input.treeCount((3, 1))
let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
echo "Example two: ", slopes.mapIt(exampleInput.treeCount(it)).foldl(a * b)
echo "Part two: ", slopes.mapIt(input.treeCount(it)).foldl(a * b)

import sequtils, strutils

const example = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]

let input = "input07.txt".readFile.strip.split(",").map(parseInt)

func fuelCosts(positions: openArray[int]): seq[int] =
  for pos in positions.min .. positions.max:
    result.add positions.mapIt(abs(pos - it)).foldl(a + b)

func fuelCosts2(positions: openArray[int]): seq[int] =
  for pos in positions.min .. positions.max:
    result.add positions.map(proc (crabPos: int): int =
      let distance = abs(pos - crabPos)
      distance * (distance + 1) div 2
    ).foldl(a + b)

echo "Example one: ", example.fuelCosts.min
echo "Part one: ", input.fuelCosts.min
echo "Example two: ", example.fuelCosts2.min
echo "Part two: ", input.fuelCosts2.min

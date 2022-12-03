import sequtils, strutils

const example = [3, 4, 3, 1, 2]

let input = "input06.txt".readFile.strip.split(',').map(parseInt)

func simulate(fish: openArray[int], days: Positive): int =
  var counts: array[0 .. 8, int]
  for timer in fish:
    inc counts[timer]
  for _ in 1 .. days:
    let zeroeCount = counts[0]
    for idx in 0 .. 7:
      counts[idx] = counts[idx + 1]
    counts[6] += zeroeCount
    counts[8] = zeroeCount
  for count in counts:
    result += count

echo "Example one (18 days, 80 days): ", example.simulate(18), ", ", example.simulate(80)
echo "Part one: ", input.simulate(80)
echo "Part two: ", input.simulate(256)

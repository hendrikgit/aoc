import std/[sequtils, strscans, strutils]

const example = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8""".splitLines

let input = "input04.txt".lines.toSeq

func contains(assignments: string): bool =
  let (match, lS, lE, rS, rE) = assignments.scanTuple("$i-$i,$i-$i")
  if match:
    return (lS >= rS and lE <= rE) or (rS >= lS and rE <= lE)

func overlaps(assignments: string): bool =
  let (match, lS, lE, rS, rE) = assignments.scanTuple("$i-$i,$i-$i")
  if match:
    return (lS >= rS and lS <= rE) or (lS <= rS and lE >= rS)

echo "Example one: ", example.map(contains).countIt(it)
echo "Part one: ", input.map(contains).countIt(it)
echo "Example two: ", example.map(overlaps).countIt(it)
echo "Part two: ", input.map(overlaps).countIt(it)

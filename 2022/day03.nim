import std/[setutils, sequtils, strutils]

const example = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw""".splitLines

let input = "input03.txt".lines.toSeq

func prio(c: char): int =
  if c.ord >= 'a'.ord:
    c.ord - 96
  else:
    c.ord - 38

func commonPrio(rucksack: string): int =
  var containsL: array[1 .. 52, bool]
  var containsR: array[1 .. 52, bool]
  for idxL in 0..rucksack.high div 2:
    let prioL = rucksack[idxL].prio
    if containsR[prioL]:
      return prioL
    else:
      containsL[prioL] = true
    let idxR = rucksack.high - idxL
    let prioR = rucksack[idxR].prio
    if containsL[prioR]:
      return prioR
    else:
      containsR[prioR] = true

func group[T](s: seq[T], num: int): seq[seq[T]] =
  var count = 0
  var subseq = newSeq[T]()
  for item in s:
    subseq.add item
    inc count
    if count == num:
      count = 0
      result.add subseq
      subseq = @[]

func badgePrio(group: seq[string]): int =
  var commonItems = Letters
  for rucksack in group:
    commonItems = commonItems * rucksack.toSet
  commonItems.toSeq[0].prio

echo "Example one: ", example.map(commonPrio).foldl(a + b)
echo "Part one: ", input.map(commonPrio).foldl(a + b)
echo "Example two: ", example.group(3).map(badgePrio).foldl(a + b)
echo "Part two: ", input.group(3).map(badgePrio).foldl(a + b)

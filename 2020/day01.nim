import algorithm, options, sequtils, strutils

let expenses = "input01.txt".lines.toSeq.map(parseInt).sorted
#let expenses = [1721, 979, 366, 299, 675, 1456]

func findSummands2(s: openArray[int], findSum: int): array[2, int] =
  var idxStart = 0
  var idxEnd = s.high
  while idxStart != idxEnd:
    let sum = s[idxStart] + s[idxEnd]
    if sum == findSum: return [s[idxStart], s[idxEnd]]
    if sum > findSum: dec idxEnd
    else: inc idxStart

func findSummands3(s: openArray[int], findSum: int): array[3, int] =
  for v1 in s:
    for v2 in s[1 .. ^1]:
      for v3 in s[2 .. ^1]:
        if v1 + v2 + v3 == findSum: return [v1, v2, v3]

proc findSummands(s: openArray[int], findSum: int, len: int): Option[seq[int]] =
  assert len >= 1
  if len == 1:
    if findSum in s: return @[findSum].some
  else:
    for v in s:
      let summands = findSummands(s, findSum - v, len - 1)
      if summands.isSome: return (@[v] & summands.get).some

echo "Part one: ", expenses.findSummands2(2020).foldl(a * b)
echo "Part one: ", expenses.findSummands(2020, 2).get.foldl(a * b)
echo "Part two: ", expenses.findSummands3(2020).foldl(a * b)
echo "Part two: ", expenses.findSummands(2020, 3).get.foldl(a * b)

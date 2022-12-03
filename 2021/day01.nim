import math, strutils, sequtils

let depths = "input01.txt".lines.toSeq.map(parseInt)

func increases(s: seq[int]): int =
  for idx in 1 .. s.high:
    if s[idx] > s[idx - 1]:
      inc result

func increases(s: seq[int], wndSz: Positive): int =
  assert s.len >= wndSz
  for idx in 1 .. s.len - wndSz:
    if s[idx - 1 .. idx + wndSz - 2].sum < s[idx .. idx + wndSz - 1].sum:
      inc result

# Because of values overlapping and being the same between two windows
# only the first and last value have to be compared.
# 199 (A)
# 200  A B
# 208  A B C
# 210   (B) C D
# 200  E   C D
# 207  E F   D
# 240  E F G
# 269    F G H
# 260      G H
# 263        H
func increasesFirstLast(s: seq[int], wndSz: Positive): int =
  assert s.len >= wndSz
  for idx in 1 .. s.len - wndSz:
    if s[idx - 1] < s[idx + wndSz - 1]:
      inc result

# Just to try a slightly different approach
func windowSum(s: seq[int], wndSz: Positive): seq[int] =
  assert s.len >= wndSz
  for idx in 0 .. s.len - wndSz:
    result.add s[idx .. idx + wndSz - 1].sum

iterator windowSumIter(s: seq[int], wndSz: Positive): int =
  assert s.len >= wndSz
  for idx in 0 .. s.len - wndSz:
    yield s[idx .. idx + wndSz - 1].sum

echo "Part one: ", depths.increases
echo "Part one: ", depths.zip(depths[1 .. ^1]).filterIt(it[1] > it[0]).len
echo "Part two: ", depths.increases(3)
echo "Part two: ", depths.increasesFirstLast(3)
echo "Part two: ", depths.windowSum(3).increases
echo "Part two: ", depths.windowSumIter(3).toSeq.increases
echo "Part two: ", depths.zip(depths[3 .. ^1]).filterIt(it[1] > it[0]).len

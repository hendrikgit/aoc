import std/[sequtils, strutils]

const example = """
30373
25512
65332
33549
35390""".splitLines

let input = "input08.txt".lines.toSeq

func visible(input: seq[string]): int =
  result += input[0].len * 2
  result += (input.len - 2) * 2
  for idxRow in 1 ..< input.high:
    let row = input[idxRow]
    for idxCol in 1 ..< row.high:
      let tree = row[idxCol]
      var visible = true
      for idxLeft in countdown(idxCol - 1, 0):
        if row[idxLeft] >= tree:
          visible = false
          break
      if visible:
        inc result
        continue
      visible = true
      for idxRight in idxCol + 1 .. row.high:
        if row[idxRight] >= tree:
          visible = false
          break
      if visible:
        inc result
        continue
      visible = true
      for idxUp in countdown(idxRow - 1, 0):
        if input[idxUp][idxCol] >= tree:
          visible = false
          break
      if visible:
        inc result
        continue
      visible = true
      for idxDown in idxRow + 1 .. input.high:
        if input[idxDown][idxCol] >= tree:
          visible = false
          break
      if visible:
        inc result

func scenicScores(input: seq[string]): seq[int] =
  for idxRow in 0 .. input.high:
    let row = input[idxRow]
    for idxCol in 0 .. row.high:
      let tree = row[idxCol]
      var left, right, up, down = 0
      for idxLeft in countdown(idxCol - 1, 0):
        inc left
        if row[idxLeft] >= tree: break
      for idxRight in idxCol + 1 .. row.high:
        inc right
        if row[idxRight] >= tree: break
      for idxUp in countdown(idxRow - 1, 0):
        inc up
        if input[idxUp][idxCol] >= tree: break
      for idxDown in idxRow + 1 .. input.high:
        inc down
        if input[idxDown][idxCol] >= tree: break
      result.add left * right * up * down

echo "Example one: ", example.visible
echo "Part one: ", input.visible
echo "Example two: ", example.scenicScores[7], "; ", example.scenicScores[17]
echo "Part two: ", input.scenicScores.max

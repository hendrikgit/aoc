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

echo "Example one: ", example.visible
echo "Part one: ", input.visible

import std/[sequtils, strscans, strutils, sugar]

const example = """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2""".splitLines

type
  Crates = seq[string]

func splitInput(input: seq[string]): tuple[crates, moves: seq[string]] =
  var crateInput = true
  for line in input:
    if line.len == 0:
      crateInput = false
      continue
    if crateInput: result.crates.add line
    else: result.moves.add line

const (exampleCrates, exampleMoves) = example.splitInput

let (inputCrates, inputMoves) = "input05.txt".lines.toSeq.splitInput

func toCrates(inputCrates: seq[string]): Crates =
  let crateStrIndices = collect:
    for idx, c in inputCrates[inputCrates.high]:
      if c != ' ': idx
  result = newSeqWith(crateStrIndices.len, "")
  for idxRow in countdown(inputCrates.high - 1, 0):
    for idxStack, idxCrateStr in crateStrIndices:
      if idxCrateStr <= inputCrates[idxRow].high and inputCrates[idxRow][idxCrateStr] != ' ':
        result[idxStack].add inputCrates[idxRow][idxCrateStr]

func rearrange(crates: Crates, moves: seq[string]): Crates =
  result = crates
  for move in moves:
    let (match, num, idxFrom, idxTo) = move.scanTuple("move $i from $i to $i")
    if match:
      let stackFrom = result[idxFrom - 1].addr
      let stackTo = result[idxTo - 1].addr
      for _ in 1 .. num:
        stackTo[].add stackFrom[][stackFrom[].high]
        stackFrom[] = stackFrom[][0 .. stackFrom[].high - 1]

func rearrange2(crates: Crates, moves: seq[string]): Crates =
  result = crates
  for move in moves:
    let (match, num, idxFrom, idxTo) = move.scanTuple("move $i from $i to $i")
    if match:
      let stackFrom = result[idxFrom - 1].addr
      let stackTo = result[idxTo - 1].addr
      stackTo[].add stackFrom[][stackFrom[].len - num .. stackFrom[].high]
      stackFrom[] = stackFrom[][0 .. stackFrom[].high - num]

func topCrate(crates: string): char =
  crates[crates.high]

echo "Example one: ", exampleCrates.toCrates.rearrange(exampleMoves).map(topCrate).join
echo "Part one: ", inputCrates.toCrates.rearrange(inputMoves).map(topCrate).join
echo "Example two: ", exampleCrates.toCrates.rearrange2(exampleMoves).map(topCrate).join
echo "Part two: ", inputCrates.toCrates.rearrange2(inputMoves).map(topCrate).join

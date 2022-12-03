import sequtils, strutils

const example = """
A Y
B X
C Z""".splitLines

let input = "input02.txt".lines.toSeq

type
  Shape = enum
    rock = 1
    paper = 2
    scissors = 3

func predWrap(s: Shape): Shape =
  if s == Shape.low: Shape.high else: s.pred

func succWrap(s: Shape): Shape =
  if s == Shape.high: Shape.low else: s.succ

func outcome(elf, me: Shape): int =
  if elf == me: return 3
  if elf == me.predWrap: return 6
  return 0

func toShape(c: char): Shape =
  result = case c
  of 'A', 'X': rock
  of 'B', 'Y': paper
  of 'C', 'Z': scissors
  else: raise newException(ValueError, "Not a valid letter for a shape")

func score(input: seq[string]): int =
  for l in input:
    let me = l[2].toShape
    result += me.ord + outcome(l[0].toShape, me)

func score2(input: seq[string]): int =
  for l in input:
    let elf = l[0].toShape
    let me = case l[2]
    of 'X': elf.predWrap # lose
    of 'Y': elf # draw
    of 'Z': elf.succWrap # win
    else: raise newException(ValueError, "Not a valid letter for a round ending")
    result += me.ord + outcome(elf, me)


echo "Example one: ", example.score
echo "Part one: ", input.score
echo "Example two: ", example.score2
echo "Part two: ", input.score2

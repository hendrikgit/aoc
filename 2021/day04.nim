import sequtils, strutils

const example = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7""".splitLines

let input = "input04.txt".lines.toSeq

type
  #Board = seq[int]
  Board = array[5, int]

func parseBingo(input: seq[string]): tuple[draw: seq[int], boards: seq[Board]] =
  #var board = newSeqOfCap[int](25)
  var board: Board
  for line in input[2 .. ^1]:
    if line != "":
      #board.add line.splitWhitespace.map(parseInt)
      let nrs = line.splitWhitespace.map(parseInt)
      for nr in nrs:
        board[^1] = nr
    else:
      result.boards.add board
      #board.setLen 0
  result.boards.add board

func isWinRow(board: Board, draw: seq[int], row: int): bool =
  for idx in (row * 5) .. (row * 5 + 4):
    if board[idx] notin draw:
      return false
  true

func isWinCol(board: Board, draw: seq[int], col: int): bool =
  for idx in countup(col, col + 20, 5):
    if board[idx] notin draw:
      return false
  true

func isWinner(board: Board, draw: seq[int]): bool =
  for idx in 0 .. 4:
    if board.isWinRow(draw, idx): return true
    if board.isWinCol(draw, idx): return true

func unmarkedNumbers(board: Board, draw: seq[int]): seq[int] =
  for nr in board:
    if nr notin draw:
      result.add nr

func winFirst(bingo: tuple[draw: seq[int], boards: seq[Board]]): tuple[board: Board, draw: seq[int]] =
  for idx in 4 .. bingo.draw.high:
    for board in bingo.boards:
      if board.isWinner(bingo.draw[0 .. idx]):
        return (board: board, draw: bingo.draw[0 .. idx])

func winLast(bingo: tuple[draw: seq[int], boards: seq[Board]]): tuple[board: Board, draw: seq[int]] =
  var winners: seq[Board]
  var drawIdxs: seq[int]
  for idx in 4 .. bingo.draw.high:
    for board in bingo.boards:
      if board in winners:
        continue
      if board.isWinner(bingo.draw[0 .. idx]):
        winners.add board
        drawIdxs.add idx
  if winners.len > 0:
    return (board: winners[^1], draw: bingo.draw[0 .. drawIdxs[^1]])

func score(winner: tuple[board: Board, draw: seq[int]]): int =
  if winner.draw.len > 0:
    return winner.board.unmarkedNumbers(winner.draw).foldl(a + b) * winner.draw[^1]

echo "Example one: ", example.parseBingo.winFirst.score
echo "Part one: ", input.parseBingo.winFirst.score
echo "Example two: ", example.parseBingo.winLast.score
echo "Part two: ", input.parseBingo.winLast.score

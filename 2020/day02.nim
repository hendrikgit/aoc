import sequtils, strscans, strutils

let exampleInput = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc""".splitLines

let input = "input02.txt".lines.toSeq

func validPasswords(s: seq[string]): int =
  for entry in s:
    var
      min, max: int
      letter: char
      password: string
    if entry.scanf("$i-$i $c: $w$.", min, max, letter, password):
      let n = password.count(letter)
      if n >= min and n <= max:
        inc result

func validPasswordsTwo(s: seq[string]): int =
  for entry in s:
    var
      pos1, pos2: int
      letter: char
      password: string
    if entry.scanf("$i-$i $c: $w$.", pos1, pos2, letter, password):
      if password[pos1 - 1] == letter xor password[pos2 - 1] == letter:
        inc result

echo "Example one: ", exampleInput.validPasswords
echo "Part one: ", input.validPasswords
echo "Example two: ", exampleInput.validPasswordsTwo
echo "Part two: ", input.validPasswordsTwo

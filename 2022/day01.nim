import sequtils, strutils

const example = """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
""".splitLines # empty line at the end

let input = "input01.txt".readFile.splitLines # keeps empty line at the end

func mostCalories(input: seq[string]): int =
  var mostCalories = 0
  var elfCalories = 0
  for l in input:
    if l == "":
      if elfCalories > mostCalories:
        mostCalories = elfCalories
      elfCalories = 0
    else:
      elfCalories += l.parseInt
  return mostCalories

func top3Calories(input: seq[string]): array[3, int] =
  var elfCalories = 0
  for l in input:
    if l == "":
      for idx in 0 .. result.high:
        if elfCalories > result[idx]:
          if idx < result.high:
            result[idx + 1 .. result.high] = result[idx .. result.high - 1]
          result[idx] = elfCalories
          break
      elfCalories = 0
    else:
      elfCalories += l.parseInt

echo "Example one: ", example.mostCalories
echo "Part one: ", input.mostCalories
echo "Example two: ", example.top3Calories, " = ", example.top3Calories.foldl(a + b)
echo "Part two: ", input.top3Calories, " = ", input.top3Calories.foldl(a + b)

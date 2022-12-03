import sequtils, strutils, tables

const example = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce""".splitLines

let input = "input08.txt".lines.toSeq

const digits = {
  2: 1,
  3: 7,
  4: 4,
  7: 8
}.toTable

type
  Output = array[4, string]

func parse(notes: seq[string]): seq[Output] =
  for line in notes:
    var output: Output
    var idx = 0
    for signal in line.split(" | ")[1].splitWhitespace:
      output[idx] = signal
      inc idx
    result.add output

func countDigits(outputs: seq[Output]): int =
  for output in outputs:
    for digit in output:
      let l = digit.len
      if digits.hasKey(l):
        inc result

echo "Example one: ", example.parse.countDigits
echo "Part one: ", input.parse.countDigits

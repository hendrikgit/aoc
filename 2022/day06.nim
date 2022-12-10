import std/[sequtils, setutils, strutils]

const example = """
mjqjpqmgbljsphdztnvjfqwrcgsmlb
bvwbjplbgvbhsrlpgdmjqwftvncz
nppdvjthqldpwncqszvftbrmjlhg
nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw""".splitLines

let input = "input06.txt".readFile

func firstMarker(input: string, length: int): int =
  for idx in length - 1 .. input.high:
    let marker = input[idx - (length - 1) .. idx].toSet
    if marker.len == length:
      return idx + 1

echo "Example one: ", example.mapIt(it.firstMarker(4))
echo "Part one: ", input.firstMarker(4)
echo "Example two: ", example.mapIt(it.firstMarker(14))
echo "Part two: ", input.firstMarker(14)

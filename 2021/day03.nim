import bitops, math, sequtils, strutils, sugar

let example = """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010""".splitLines

let input = "input03.txt".lines.toSeq

type
  Count = tuple
    zero, one: int

func countZeroOne(nums: seq[string]): seq[Count] =
  result = newSeqWith(nums[0].len, (0, 0))
  for num in nums:
    for idx, bit in num:
      if bit == '1':
        inc result[idx].one
      else:
        inc result[idx].zero

func toDec(counts: seq[Count]): int =
  for count in counts:
    result = result shl 1
    if count.one >= count.zero:
      result = result xor 1

func flip(num: int): int =
  #result = num
  #for idx in 0 .. result.fastLog2:
  #  result.flipBit(idx)
  2 ^ (num.fastLog2 + 1) - num - 1

func power(nums: seq[string]): int =
  let gamma = nums.countZeroOne.toDec
  gamma * gamma.flip

func lifeSupport(nums: seq[string], bitCriterion: (count: Count) -> char): int =
  var nums = nums
  for idx in 0 ..< nums[0].len:
    let mostCommon = nums.countZeroOne[idx].bitCriterion
    nums = nums.filterIt it[idx] == mostCommon
    if nums.len == 1:
      return nums[0].parseBinInt

func lifeSupport(nums: seq[string]): int =
  let oxygen = (count: Count) => (if count.one >= count.zero: '1' else: '0')
  let c02 = (count: Count) => (if count.zero <= count.one: '0' else: '1')
  nums.lifeSupport(oxygen) * nums.lifeSupport(c02)

echo "Example one: ", example.power
echo "Part one: ", input.power
echo "Example two: ", example.lifeSupport
echo "Part two: ", input.lifeSupport

import strutils, tables

let example = """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in"""

let input = "input04.txt".readFile

type
  Passport = Table[string, string]

func parsePassports(input: string): seq[Passport] =
  var passport = Passport()
  for l in input.splitLines:
    if l == "":
      result.add passport
      passport = Passport()
      continue
    for pair in l.split:
      let kv = pair.split(':')
      passport[kv[0]] = kv[1]
  result.add passport

func filterValid(passports: seq[Passport]): seq[Passport] =
  const required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  for passport in passports:
    var add = true
    for key in required:
      if key notin passport:
        add = false
        break
    if add:
      result.add passport

echo "Example one: ", example.parsePassports.filterValid.len
echo "Part one: ", input.parsePassports.filterValid.len

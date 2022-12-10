import std/[sequtils, strutils]

const example = """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k""".splitLines

let input = "input07.txt".lines.toSeq

type
  File = int
  Dir = object
    parent: ptr Dir
    files: seq[File]
    dirs: seq[Dir]

func dirTree(input: seq[string]): Dir =
  var cwd = result.addr
  for l in input[1 .. input.high]:
    if l == "$ ls" or l.startsWith("dir "): continue
    if l.startsWith("$ cd .."):
      cwd = cwd.parent
    elif l.startsWith("$ cd "):
      cwd.dirs.add Dir(parent: cwd)
      cwd = cwd.dirs[cwd.dirs.high].addr
    else:
      cwd.files.add l.split(" ")[0].parseInt

func dirSize(dir: Dir): int =
  for file in dir.files:
    result += file
  for subdir in dir.dirs:
    result += subdir.dirSize

func dirSizes(dir: Dir): seq[int] =
  result.add dir.dirSize
  for subdir in dir.dirs:
    result.add subdir.dirSizes

func spaceToFree(dir: Dir): int =
  30_000_000 - (70_000_000 - dir.dirSize)

echo "Example one: ", example.dirTree.dirSizes.filterIt(it <= 100_000).foldl(a + b)
echo "Part one: ", input.dirTree.dirSizes.filterIt(it <= 100_000).foldl(a + b)
echo "Example two: ", example.dirTree.dirSizes.filterIt(it >= example.dirTree.spaceToFree).min
echo "Part two: ", input.dirTree.dirSizes.filterIt(it >= input.dirTree.spaceToFree).min

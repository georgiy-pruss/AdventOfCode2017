import strutils,sets,algorithm

let text = splitLines strip readFile "04.dat"
var cnt,cnt2 = 0
for line in text:
  var dict = initSet[string]()
  var dict2 = initSet[string]()
  var valid,valid2 = true
  for word in split line:
    if dict.contains word:
      valid = false
    else:
      dict.incl word # why not add?
    var w2 = word
    w2.sort cmp
    if dict2.contains w2:
      valid2 = false
    else:
      dict2.incl w2
  if valid: cnt += 1
  if valid2: cnt2 += 1
echo cnt
echo cnt2

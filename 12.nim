import strutils,sequtils,tables,sets

var links = initTable[int,seq[int]]() # links of items to other items
var maxid = 0 # we'll need to enumerate them all, so this is the max id
for line in splitLines strip readFile"12.dat":
  let items = map( split(replace(replace(line,",")," <->")), parseInt )
  links[ items[0] ] = items[1..^1]
  maxid = max(maxid, max(items))

proc add( s: var HashSet[int], x: int ) =
  s.incl x
  for y in links[x]:
    if y notin s:
      add s, y
  links.del x

var s = initSet[int]()
add s, 0
echo s.len # part 1 - 175
var groups = 1
for i in 1..maxid:
  if i in links:
    groups += 1
    var s = initSet[int]()
    add s, i
echo groups # part 2 - 213

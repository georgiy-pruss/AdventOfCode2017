import strutils,sequtils
template loop(stmts: untyped): untyped = # make Nim prettier
  while true: stmts # while true is so ugly! C has for(;;) at least

type Dir = enum up,down,left,right # this order, for the step array
type Pos = tuple[x:int, y:int] # Position, everybody knows this type
const step: array[Dir,Pos] = [(0,-1),(0,+1),(-1,0),(+1,0)]
proc `+`(a,b:Pos):Pos = (a.x+b.x, a.y+b.y) # make life easier
proc good( map:seq[string], p:Pos ):bool = p.y>=0 and p.y<map.len and p.x>=0 and p.x<map[p.y].len

var answer1: string = "" # part 1 - accumulated string
var answer2: int = 0     # part 2 - total steps

proc move( map:seq[string], p:Pos, d:Dir ):Pos = # move in one direction
  var n = p + step[d]; inc answer2 # count each step!
  while map[n.y][n.x]!='+' and map[n.y][n.x]!=' ': # '+' -- turn, ' ' -- quit
    if map[n.y][n.x].isAlphaAscii: answer1 &= map[n.y][n.x] # accumulate letters
    n = n + step[d]; inc answer2 # move, move, move
  return n # end position of the movement - then do turn or exit

let map = "19.dat".readFile.splitLines # don't strip! blanks are important!
var p:Pos = (map[0].find('|'),0) # start position
var d:Dir = down # start direction
loop:
  p = move( map, p, d ) # move in direction d while possible
  if map[p.y][p.x]==' ': break # the blank signals it's the end woohooo
  let (c1,c2,r) = if d in [up,down]: (left,right,'-') else: (up,down,'|') # candidates
  for c in [c1,c2]:
    let pc = p + step[c] # candidate position
    if good( map, pc ) and (map[pc.y][pc.x]==r or map[pc.y][pc.x].isAlphaAscii):
      p = pc; d = c; inc answer2; break # break this candidate loop, continue main loop

echo answer1
echo answer2

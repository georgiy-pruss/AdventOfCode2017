import strutils
proc dist( n, ne, nw: int ): int = abs(n)+abs(ne)+abs(nw) - min(abs(n),min(abs(ne),abs(nw)))
var n,ne,nw = 0
var max_dist = 0
for x in (strip readFile"11.dat").split',':
  case x:
  of "n":  n+=1
  of "s":  n-=1
  of "ne": ne+=1
  of "sw": ne-=1
  of "nw": nw+=1
  of "se": nw-=1
  let d = dist(n,ne,nw)
  if d>max_dist:
    max_dist = d
echo dist(n,ne,nw) # Part 1: 761
echo max_dist      # Part 2: 1542

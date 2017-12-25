import strutils,sequtils

var data = "24.dat".readFile().strip().splitLines().mapIt((it&"/0").split("/").map(parseInt))

var max_sum = 0
var max_sums: seq[int] = @[]

proc f( s:int, k:int, curr_sum:int ) =
  var found = false
  for i,d in data:
    if d[2]==1: # already used
      continue
    if d[0]==s: # s/x
      found = true
      data[i][2] = 1; f( d[1], k+1, curr_sum+d[0]+d[1] ); data[i][2] = 0
    elif d[1]==s: # x/s
      found = true
      data[i][2] = 1; f( d[0], k+1, curr_sum+d[0]+d[1] ); data[i][2] = 0
  if not found:
    if curr_sum>max_sum:
      max_sum = curr_sum
    while max_sums.len<=k: max_sums.add 0
    if curr_sum>max_sums[k]:
      max_sums[k] = curr_sum

f 0,0,0
echo max_sum      # 1656
echo max_sums[^1] # 1642, len is 31

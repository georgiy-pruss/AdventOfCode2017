import strutils,sequtils,tables,os

var dn = initTable[string,string]()      # down - to the bottom
var up = initTable[string,seq[string]]() # up - to leaves
var wt = initTable[string,(int,int)]()   # weight: own,total

proc read_data( fname: string ) = # fill in dn,up,wt
  for line in fname.readFile.strip.splitLines:
    let x = line.replace(" ","").split"->"
    if x.len > 1:
      let base = x[0].split("(")[0]
      let ups = x[1].split(",")
      up[base] = ups
      for name in ups:
        dn[name] = base
    let w = x[0][0..< ^1].split"("
    wt[w[0]] = (w[1].parseInt,0)

proc get_bottom(): string =
  for k,v in dn: # we need any node, from any table, let it be one from dn
    var n = dn[k]
    while n in dn: n = dn[n]
    return n

proc calc_weights( x:string ): int {.discardable.} =
  var w = wt[x][0]
  if x in up:
    for v in up[x]:
      w += calc_weights(v)
  wt[x][1] = w
  return w

proc rebalance( node:string ): int =
  if wt[node][0] == wt[node][1]: return 0 # leaf, no rebalance
  let x: seq[string] = up[node] # sub-nodes = branches
  var w_must,w_bad,i_bad = -1
  let w0 = wt[x[0]][1];
  let w1 = wt[x[1]][1];
  if w0==w1: # not 0 or 1
    w_must = w0
    for i,xi in x:
      if i<2: continue # skip w0,w1
      let wi = wt[xi][1];
      if wi!=w0: i_bad = i; w_bad = wi
  else: # either 0 or 1
    w_must = wt[x[2]][1]; # so w2 must be good
    if w0==w_must: i_bad = 1; w_bad = w1
    else:          i_bad = 0; w_bad = w0
  if i_bad < 0: return 0 # all were the same
  let b = rebalance( x[i_bad] )
  if b != 0: return b # could rebalance in branch, just return
  return wt[x[i_bad]][0] + (w_must-w_bad) # do balance x[i_bad]!

read_data( if paramCount()>0: paramStr(1) else: "07.dat" )
let bottom = get_bottom()
echo bottom
calc_weights( bottom )
echo rebalance( bottom )

import strutils,sequtils,tables

proc cond( x,y: int, c: string ): bool =
  case c:
  of "==": return x==y
  of "!=": return x!=y
  of "<":  return x<y
  of "<=": return x<=y
  of ">":  return x>y
  of ">=": return x>=y

var r = initTable[string,int]()
var g = -9999

for line in splitLines strip readFile"08.dat":
  let tt = split line # tokens
  let cr = tt[4]
  let cv = if cr in r: r[cr] else: 0
  let cc = tt[5]
  let cn = parseInt tt[6]
  var rn = parseInt tt[2]
  if tt[1]=="dec": rn *= -1
  if cond(cv,cn,cc):
    let rr = tt[0]
    let rv = if rr in r: r[rr] else: 0
    let y = rv + rn
    r[rr] = y
    if y>g: g=y

var m = -9999
for k,v in r:
  if v>m: m=v

echo m
echo g

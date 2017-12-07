import strutils,sequtils,times

proc step( m: var seq[int], n: int ) =
  let e = max(m)
  let i = m.find e
  m[i] = 0
  let d = e div n; for j in 0..<n: m[j] += d
  let r = e mod n; for j in i+1..i+r: m[j mod n] += 1

proc solve( arg_m: seq[int] ) =
  var m = arg_m; let n = len m
  var t = @[ m ]
  while true:
    step m,n
    let i = t.find m
    if i>0:
      echo len(t),' ',len(t)-i
      return
    t.add m

solve "06.dat".readFile.strip.split.map parseInt


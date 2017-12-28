import sequtils,strutils

var p,v,a: seq[seq[int]] = @[]
for line in lines"20.dat":
  let s = line.multiReplace(("p=<",""),("v=<",""),("a=<",""),(">",""),(", "," "),(","," "))
  let t = s.split.map parseInt
  p.add t[0..2]; v.add t[3..5]; a.add t[6..8]

template move( p,v,a: var seq[seq[int]] ) =
  for j,e in a: v[j][0]+=e[0]; v[j][1]+=e[1]; v[j][2]+=e[2]
  for j,e in v: p[j][0]+=e[0]; p[j][1]+=e[1]; p[j][2]+=e[2]

proc calcdist( p: seq[seq[int]] ): seq[int] =
  result = @[]
  # distances between all points
  for j in 0..<p.len:
    for k in j+1..<p.len:
      result.add abs(p[j][0]-p[j][0])
      result.add abs(p[j][1]-p[j][1])
      result.add abs(p[j][2]-p[j][2])
  # distances to (0,0,0)
  for j in 0..<p.len:
    result.add abs(p[j][0])
    result.add abs(p[j][1])
    result.add abs(p[j][2])

proc p1( px,vx,ax: seq[seq[int]] ): int =
  var p = px; var v = vx; var a = ax
  var distances,distances2: seq[int]
  for i in 0..1000: # it will break at i=291
    move p,v,a
    # check end of changes
    if i==0:
      distances = calcdist p
    else:
      distances2 = calcdist p
      var done = true
      for j,d2 in distances2:
        if d2<distances[j]: done=false; break
      if done:
        break
      distances = distances2
  var mindist = int.high
  var idx = -1
  for i,xyz in p:
    let dist = abs(xyz[0])+abs(xyz[1])+abs(xyz[2])
    if dist<mindist: mindist = dist; idx = i
  return idx

proc p2( px,vx,ax: seq[seq[int]] ): int =
  var p = px; var v = vx; var a = ax
  var distances,distances2: seq[int] = @[]
  for i in 0..1000: # it will break at i=168
    move p,v,a
    # check collisions
    var n = p.len
    var j = 0
    while j<n:
      var collision = false
      var k = j+1
      while k<n:
        if p[j][0]==p[k][0] and p[j][1]==p[k][1] and p[j][2]==p[k][2]:
          p.del k; v.del k; a.del k; dec n
          collision = true
          distances = @[]
        else:
          inc k
      if collision:
        p.del j; v.del j; a.del j; dec n
      else:
        inc j
    # check end of changes
    if distances.len==0:
      distances = calcdist p
    else:
      distances2 = calcdist p
      var done = true
      for j,d2 in distances2:
        if d2<distances[j]: done=false; break
      if done:
        break
      distances = distances2
  return p.len

echo p1( p,v,a ) # 161 6.9s
echo p2( p,v,a ) # 438 1.0s


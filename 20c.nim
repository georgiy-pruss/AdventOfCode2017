import sequtils,strutils
var p,v,a:seq[seq[int]]= @[]
for line in lines"20.dat":
 let s=line.multiReplace(("p=<",""),("v=<",""),("a=<",""),(">",""),(", "," "),(","," "))
 let t=s.split.map parseInt
 p.add t[0..2];v.add t[3..5];a.add t[6..8]
template M(p,v,a: var seq[seq[int]])=
 for j,e in a:v[j][0]+=e[0];v[j][1]+=e[1];v[j][2]+=e[2]
 for j,e in v:p[j][0]+=e[0];p[j][1]+=e[1];p[j][2]+=e[2]
proc w(x,y,z:seq[seq[int]]):int=
 var p=x;var v=y;var a=z
 for i in 0..333:M p,v,a
 var m=int.high;var n= -1
 for i,o in p:
  let d=abs(o[0])+abs(o[1])+abs(o[2])
  if d<m:m=d;n=i
 return n
proc q(z,b,c:seq[seq[int]]):int=
 var p=z;var v=b;var a=c
 for i in 0..333:
   M p,v,a;var n=p.len;var j=0
   while j<n:
    var c=false;var k=j+1
    while k<n:
     if p[j][0]==p[k][0] and p[j][1]==p[k][1] and p[j][2]==p[k][2]:
      c=true;p.del k;v.del k;a.del k;dec n
     else:inc k
    if c:p.del j;v.del j;a.del j;dec n
    else:inc j
 return p.len
echo w( p,v,a )
echo q( p,v,a )

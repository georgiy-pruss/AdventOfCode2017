import strutils,sequtils
var t="24.dat".readFile.strip.splitLines.mapIt((it&"/0").split("/").map parseInt)
var p=0;var q= @[0]
proc f(s,k,c:int=0)=
 var g,z=0
 for i,d in t:
  if d[2]==0:
   if d[0]==s:z=d[1]elif d[1]==s:z=d[0]else:continue
   g=1;t[i][2]=1;f(z,k+1,c+d[0]+d[1]);t[i][2]=0
 if g==0:
  if c>p:p=c
  while q.len<=k:q.add 0
  if c>q[k]:q[k]=c
f();echo p;echo q[^1]

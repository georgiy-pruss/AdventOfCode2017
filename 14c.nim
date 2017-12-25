import sequtils,strutils
import KnotHash
const data="uugsqrei"
const NR=128
const NC=128
proc c2num(c:char):int=(if c<'a':ord(c)-ord('0')else:ord(c)-ord('a')+10)
proc c2bits(c:char):int=[0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4][c2num(c)]
var n=0
for i in 0..<NR:n+=foldl(KnotHash.hash(data&"-"& $i),a+c2bits(b),0)
echo n
var m:array[NR,array[NC,int]]
for i in 0..<NR:
 for j,c in KnotHash.hash(data&"-"& $i):
  let v=c2num(c)
  for k in 0..3:m[i][4*j+k]= -((v shr(3-k))and 1)
proc paint(i,j:int,c:int)=
 m[i][j]=c
 if j<NC-1 and m[i][j+1]<0:paint i,j+1,c
 if i<NR-1 and m[i+1][j]<0:paint i+1,j,c
 if j>0 and m[i][j-1]<0:paint i,j-1,c
 if i>0 and m[i-1][j]<0:paint i-1,j,c
var c=0
for i in 0..<NR:
 for j in 0..<NC:
  if m[i][j]<0:
   c+=1;paint i,j,c
echo c

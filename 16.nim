import strutils,sequtils

let cmds="16.dat".readFile.strip.split','

proc tr(s:string,c:string):string =
  result=s
  if c[0]=='s':
    let n = parseInt(c[1..^1])
    result = result[^n..^1] & result[0..< ^n]
  elif c[0]=='x':
    let ij = map(c[1..^1].split'/',parseInt)
    swap result[ij[0]], result[ij[1]]
  else:
    swap result[s.find(c[1])], result[s.find(c[3])]

const a = "abcdefghijklmnop"

echo foldl( cmds, tr(a,b), a ) # one step

var k=0
var s=a
for i in 1..100:
  s = foldl( cmds, tr(a,b), s )
  if s==a:
    k=i
    break

s = a
for i in 1..(1000000000 mod k):
  s = foldl( cmds, tr(a,b), s )
echo s # 1e9 mod k steps

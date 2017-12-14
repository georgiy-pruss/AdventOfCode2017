import sequtils,strutils
import KnotHash

const data = "uugsqrei" # "flqrgnkx" for test - 8108 1242
const NR = 128          # number of rows -- arbitrary
const NC = 128          # number of columns -- 32 chars in hash x 4 bits per char

proc c2num( c: char ): int = (if c<'a': ord(c)-ord('0') else: ord(c)-ord('a')+10)
proc c2bits( c: char ): int = [0,1,1,2, 1,2,2,3, 1,2,2,3, 2,3,3,4][c2num(c)]

var n = 0 # no nested folds, so it's a loop
for i in 0..<NR: n += foldl( KnotHash.hash(data & "-" & $i), a + c2bits(b), 0 )
echo n # Part 1, was easy, 8194

# Part 2 - painting areas with different colors

var m: array[NR,array[NC,int]]
for i in 0..<NR:
  for j,c in KnotHash.hash(data & "-" & $i):
    let v = c2num(c)
    for k in 0..3: m[i][4*j+k] = -((v shr (3-k)) and 1) # 0 if free or -1 if occupied

proc paint( i,j: int, c: int ) =
  m[i][j] = c
  if j<NC-1 and m[i][j+1]<0: paint(i,j+1,c)
  if i<NR-1 and m[i+1][j]<0: paint(i+1,j,c)
  if j>0 and m[i][j-1]<0: paint(i,j-1,c)
  if i>0 and m[i-1][j]<0: paint(i-1,j,c)

var c = 0 # number of areas done, or index of color
for i in 0..<NR:
  for j in 0..<NC:
    if m[i][j]<0: # occupied but not painted yet
      c += 1 # found one more area, one more color
      paint(i,j,c)
echo c # Part 2, 1141

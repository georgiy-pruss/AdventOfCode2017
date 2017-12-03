import strutils, sequtils
var s,s2 = 0
for line in splitLines strip readFile "02.dat":
  let row = line.split().map(parseInt)
  s += max(row)-min(row)
  for i in 0..<len(row):
    for j in 0..<len(row):
      if i!=j and row[i] mod row[j] == 0:
        s2 += row[i] div row[j]
echo s,' ',s2

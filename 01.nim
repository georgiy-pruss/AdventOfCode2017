import strutils
const orig = - int '0'
let code = strip readFile "01.dat"
let lenc = code.len; let half = lenc div 2
var sum, sum2 = 0
for i,c in code:
  if c == code[(i+1)mod lenc]: sum += orig + int c
  if c == code[(i+half)mod lenc]: sum2 += orig + int c
echo sum, ' ', sum2

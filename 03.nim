import math # sqrt

const n = 265149

# Part 1: Distance, calculate

proc d(n:int):int =
  let f = int sqrt float64 n-1; let h=f div 2; let q=f mod 2; let g=f*f
  return abs(n-h-1-g-(if n<g+f+2:0 else:f+q))+h+q

echo d n

# Part 2: A141481 http://oeis.org/A141481

var z : seq[seq[int]] = @[]

z.add @[1]         # base element
z.add @[1]         # then two segments of length 1
z.add @[2]
z.add @[4,5]       # then two segments of length 2
z.add @[10,11]
z.add @[23,25,26]  # then length 3
z.add @[54,57,59]  # and 4,5,etc will be calculated in g

proc g( z:seq[seq[int]], k:int ): seq[int] = # generate
  var r = @[ z[^1][^1] + z[^1][^2] + z[^5][^1] + z[^4][0] ]
  r.add( r[^1] + z[^5][^1] + z[^4][0] + z[^4][1] )
  for i in 2..k-3:
    r.add( r[^1] + z[^4][i-2] + z[^4][i-1] + z[^4][i] )
  r.add( r[^1] + z[^4][^2] + z[^4][^1] )
  r.add( r[^1] + z[^4][^1] )
  return r

proc a( s:seq[int], n:int ): bool = # answer
  for x in s:
    if x>n:
      echo x
      return true
  return false

for i in 4..99:
  let s = g(z,i)
  if a(s,n): break
  z.add s
  let t = g(z,i)
  if a(t,n): break
  z.add t

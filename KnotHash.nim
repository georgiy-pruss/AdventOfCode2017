import strutils,sequtils

const N = 256

type KnotHash = object
  nums: array[N,int]
  curr: int
  skip: int

proc init( k: var KnotHash ) =
  k.curr = 0
  k.skip = 0
  for i in 0..<N: k.nums[i] = i # iota N

proc reverse( k: var KnotHash, span: int ) =
  for i in 0..< span div 2:
    swap k.nums[(k.curr+i) mod N], k.nums[(k.curr+span-i-1) mod N]

proc round( k: var KnotHash, s: seq[int] ) = # do one round of hashing
  for span in s:
    reverse k, span
    k.curr = (k.curr + span + k.skip)mod N
    k.skip += 1

proc hh( n: int ): string = # like "%02x" % n
  result = ".."
  result[0] = "0123456789abcdef"[ n div 16 ]
  result[1] = "0123456789abcdef"[ n mod 16 ]

proc hash*( s: string ): string =
  var lens = s.mapIt( int, ord(it) )
  lens.add( @[17,31,73,47,23] )
  var o: KnotHash
  init o
  for i in 0..<64: round o, lens
  var res = ""
  for i in 0..<16:                      # map slices?
    res &= hh foldl( o.nums[16*i..<16*(i+1)], a xor b )
  return res

assert "a2582a3a0e66e6e86e3812dcb672a272" == hash ""
assert "33efeb34ea91902bb2f59c9920caa6cd" == hash "AoC 2017"
assert "3efbe78a8d82f29979031a4aa0b16a9d" == hash "1,2,3"
assert "63960835bcdc130f0b66d7ff4f6a5a8e" == hash "1,2,4"

when isMainModule:

  let text = strip readFile"10.dat"

  var o: KnotHash
  init o
  round o, map(text.split',',parseInt)
  echo o.nums[0]*o.nums[1]

  echo hash text

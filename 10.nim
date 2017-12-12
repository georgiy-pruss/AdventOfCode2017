import strutils,sequtils

const N = 256
var nums: array[N,int] # global vars, can be made a structure (TODO)
var curr, skip: int

proc init() =
  curr = 0
  skip = 0
  for i in 0..<N: nums[i] = i # iota N

proc rotate( nums: var array[N,int], span, curr: int ) =
  for i in 0..< span div 2: # swap at curr+i and curr+span-i-1
    let t = nums[(curr+i) mod N]
    nums[(curr+i) mod N] = nums[(curr+span-i-1) mod N]
    nums[(curr+span-i-1) mod N] = t

proc round( s: seq[int] ) = # do one round of hashing
  for span in s:
    rotate nums, span, curr
    curr = (curr + span + skip)mod N
    skip = (skip + 1)mod N

proc hh( n: int ): string = # like "%02x" % n
  result = ".."
  result[0] = "0123456789abcdef"[ n div 16 ]
  result[1] = "0123456789abcdef"[ n mod 16 ]

proc hash( s: string ): string =
  var lens: seq[int] = @[]
  for c in s: lens.add ord c            # lens = s map ord
  for x in [17,31,73,47,23]: lens.add x # lens = lens add [17,31,73,47,23]
  init()
  for i in 0..<64: round lens
  var res = ""
  for i in 0..<16:                      # map slices?
    var n = 0
    for j in 0..<16:
      n = n xor nums[16*i+j]            # fold/reduce?
    res &= hh n
  return res

assert "a2582a3a0e66e6e86e3812dcb672a272" == hash ""
assert "33efeb34ea91902bb2f59c9920caa6cd" == hash "AoC 2017"
assert "3efbe78a8d82f29979031a4aa0b16a9d" == hash "1,2,3"
assert "63960835bcdc130f0b66d7ff4f6a5a8e" == hash "1,2,4"

# ------ main ------

let text = strip readFile"10.dat"

init()
round map(text.split',',parseInt)
echo nums[0]*nums[1] # Part 1 -- 48705

echo hash text       # Part 2 -- 1c46642b6f2bc21db2a2149d0aeeae5d

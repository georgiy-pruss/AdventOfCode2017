text=: LF-.~CR-.~fread'10.dat' NB. one-line input

init=: 3 : 'curr=: skip=: 0 [ nums=: i.256' NB. init data for hash round

round=: 3 : 0 NB. do one round; nums,curr,skip are input/output vars
  n=.#nums
  for_len. y do.
    nums=: (|.@(len&{.) , len&}.)&.(curr&|.) nums
    curr=: n|curr + len + skip
    skip=: n|>:skip
  end.
)

init ''
round ".text
echo */2{.nums NB. Part 1 -- 48705

xor=: 22 b.                         NB. xor for ints
d2hh=:'0123456789abcdef'{~16 16#:]  NB. format "%02x"

hash=: 3 : 0 NB. calculate hash of ASCII string, return hex digest (32 chars)
  ints=. a.i.y NB. convert ASCII input to ints
  lens=: ints, 17 31 73 47 23 NB. add salt
  init ''
  for_i. i.64 do. round lens end. NB. 64 rounds
  ,d2hh _16 xor/\ nums NB. sparse hash to dense hash
)

assert 'a2582a3a0e66e6e86e3812dcb672a272' -: hash ''
assert '33efeb34ea91902bb2f59c9920caa6cd' -: hash 'AoC 2017'
assert '3efbe78a8d82f29979031a4aa0b16a9d' -: hash '1,2,3'
assert '63960835bcdc130f0b66d7ff4f6a5a8e' -: hash '1,2,4'

echo hash text NB. Part 2 -- 1c46642b6f2bc21db2a2149d0aeeae5d

exit 0

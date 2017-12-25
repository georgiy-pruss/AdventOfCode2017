const N = 366 # input

var s: seq[int] = @[0] # spinlock
var c: int = 0 # current position

for k in 1..2017:
  c = (c + N) mod s.len + 1
  s.insert k, c

echo s[s.find(2017)+1]

var m = s.len # now we need only length
var r = s[1]  # and only s[1]
for k in 2018..50_000_000:
  c = (c + N) mod m + 1
  if c==1: r = k
  inc m

echo r

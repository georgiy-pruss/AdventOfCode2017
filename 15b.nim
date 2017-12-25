var m: uint = 289 # 65
var n: uint = 629 # 8921

proc g(): uint =
  m = m * 16807 mod 2147483647
  return m

proc h(): uint =
  n = n * 48271 mod 2147483647
  return n

var c = 0
for i in 0..<40_000_000:
  let p = g()
  let q = h()
  if ((p xor q) and 0xFFFF) == 0: inc c
echo c

m = 289
n = 629

proc g2(): uint =
  var v = g()
  while v mod 4 != 0: v = g()
  return v

proc h2(): uint =
  var v = h()
  while v mod 8 != 0: v = h()
  return v

c = 0
for i in 0..<5_000_000:
  let p = g2()
  let q = h2()
  if ((p xor q) and 0xFFFF) == 0: inc c
echo c

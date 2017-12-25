import sequtils
var m: uint = 289; var n: uint = 629
proc g(): uint = (m = m * 16807 mod 2147483647; m)
proc h(): uint = (n = n * 48271 mod 2147483647; n)
echo foldl( toSeq(0..<40_000_000), a + int(((g() xor h()) and 0xFFFF) == 0) )
m = 289; n = 629
proc g2(): uint = (var v = g(); while v mod 4 != 0: v = g(); v)
proc h2(): uint = (var v = h(); while v mod 8 != 0: v = h(); v)
echo foldl( toSeq(0..<5_000_000), a + int(((g2() xor h2()) and 0xFFFF) == 0) )

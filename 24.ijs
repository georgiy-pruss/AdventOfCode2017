'a b u'=:,&0|:".@(rplc&'/ ')&>cutLF CR-.~fread'24.dat'
f=:4 : 0 NB. x - number to find; y - curr.length, curr.sum
  found=.0
  for_i.i.#u do.if.i{u do.continue.end.
    if.x=i{a do.found=.1[v=.i{a+t=.i{b else.
    if.x=i{b do.found=.1[v=.i{b+t=.i{a else.continue.end.end.
    u=:0 i}u [ t f y+1,v [ u=:1 i}u
  end.
  if.-.found do.m=:m({.y)}~({:y)>.m{~{.y end.
)
0 f 0 0 [ m=:u NB. m - max sums; u - if pair a/b is used
echo (>./m),([:{:~:&0#[)m NB. 1656 1642 ≈42s
exit 0

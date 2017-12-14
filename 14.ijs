use'kh.ijs' NB. hash str -> str32

data=: 'uugsqrei' [ NR=: NC=: 128

i2h=: [: hash data,'-',":
c2n=: '0123456789abcdef'&i.
c2b=: {&0 1 1 2 1 2 2 3 1 2 2 3 2 3 3 4 @ c2n

echo +/,c2b@i2h"0 i.NR

m=: ([:,(4$2)#:c2n@i2h)"0 i.NR

w=: 3 : 0 NB. wipe area
  m=:0(<'i j'=.y)}m
  if.j<<:NC do.if.(>:j){i{m do.w y+0 1 end.end.
  if.i<<:NR do.if.j{(>:i){m do.w y+1 0 end.end.
  if.j>0 do.if.(<:j){i{m do.w y-0 1 end.end.
  if.i>0 do.if.j{(<:i){m do.w y-1 0 end.end.
)

echo 3 :'for_i.i.NR do.for_j.i.NC do.if.(<i,j){m do.w i,j[y=.>:y end.end.end.y'0

exit 0

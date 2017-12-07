t=: 3 : 'h+q+|y->:h+g+(f+q)*y>:2+f+g=.*:f[q=.2|f[h=.<.-:f=.<.%:<:y'

echo t 265149 NB. 438 - http://oeis.org/A214526

g=: 4 : 0
  r=.r,({:r)+v+1{u [ r=.({:>{:x)+(_2{>{:x)+v=.({:>_5{x)+{.u=.>_4{x
  for_i. i.y-4 do. r=.r,({:r)++/u{~i+i.3 end.
  r,({:r)+{:u [ r=.r,({:r)++/_2 _1{u
)

a=: 3 : 0
  z=.1;1;2;4 5;10 11;23 25 26;54 57 59
  for_k. 4+i.99 do. for_j. 0 1 do.
    if. +./y<s=.z g k do. s{~1 i.~ y<s return. end. z=.z,<s
  end. end.
)

echo a 265149 NB. 266330 - http://oeis.org/A141481

exit 0

3 :0 N=:366
  s=.,c=.0
  for_k.>:i.2017 do.
    c=.>:(#s)|c+y
    s=.(c{.s),k,c}.s
  end.
  echo s{~>:s i.2017
)
3 :0 N
  m=.1[r=.c=.0
  for_k.>:i.50000000 do.
    c=.>:m|c+y
    if.c=1 do.r=.k end.
    m=.>:m
  end.
  echo r
)
exit 0

d=: <;._1',',rplc&'/ 'LF-.~CR-.~fread '16.dat'
v=: a.{~(a.i.'a')+i.16

f =: 4 : 0 NB. apply x to y
  select. {.c=.>x
  case. 'x' do. <o(|.v)}>y [ o=. (v=.".}.c) { >y
  case. 'p' do. <o(|.v)}>y [ o=. (v=.(>y) i.1 3{c) { >y
  case. 's' do. <(>y)|.~-".}.c
  end.
)

echo >f/ |.v;d

k=: 3 : 0 v
  v=.y
  for_i. i. 999 do.
    y=.>f/ |.y;d
    if. v-:y do. >:i return. end.
  end.
)

echo 3 : 0 v
  for_i. i. k|1000000000 do.
    y=.>f/ |.y;d
  end.
  y
)

exit 0

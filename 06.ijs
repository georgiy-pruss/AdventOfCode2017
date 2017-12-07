m=: ".;._2 TAB,~LF-.~CR-.~fread '06.dat' NB. input memory state

d=: 3 : 0        NB. distribute max element - i.e. do 1 step
  n=. #y         NB. length of vector
  i=. (i.>./) y  NB. index of first occurrence of maximum of m
  e=. i{y        NB. max element
  y=. 0 i}y      NB. remove that element
  y=. y + <.e%n  NB. add 'for each' part
  r=. n{.1#~n|e  NB. find 'the rest' part
  y + r|.~->:i   NB. rotate it, add, return
)

t=: 6!:1 ''
3 : 0 m          NB. solve both tasks, define fn and run at once
  a =. ,: y      NB. table of all states of memory
  while. 1 do.
    y =. d y     NB. do distrbution
    if. (#a) > a i. y do. NB. if already in the table
      echo #a             NB. print the table size
      echo (#a) - a i. y  NB. print the cycle size
      return.
    end.
    a =. a,y     NB. add new memory state to the table
  end.
)
echo t-~6!:1 ''

exit 0

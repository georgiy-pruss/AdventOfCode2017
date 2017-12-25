d=: ".&>cutLF rplc&', -_'-.&'pav=<>'CR-.~fread'20.dat'
p=: 3&{.&.|:d      NB. positions
v=: 3 4 5&{&.|:d   NB. velocities
a=: _3&{.&.|:d     NB. accelerations
echo 3 : 0 p;v;a   NB. part 1
  'p v a'=.y
  whilst. -. *./,(pp<:|p)*.((v=0)+.(*p)=*v)*.(a=0)+.(*v)=*a do. NB. is 'the long run' yet?
    pp=.|p         NB. previous position distances
    p=.p+v=.v+a    NB. move it!
  end.
  i.&1(=<./)+/"1|p NB. find index of the closest point
)
echo 3 : 0 p;v;a   NB. part 2
  'p v a'=.y
  while.do.        NB. can't have condition here because #p can be ~: #pp
    pn=.#pp=.|p    NB. points in previous state, previous position distances
    p=.p+v=.v+a    NB. move it!
    u=.~:p                         NB. unique positions
    s=.(1=[:+/"1=)p                NB. not collided
    p=.s#u#p [ v=.s#u#v [ a=.s#u#a NB. remove collisions
    if. pn~:#p do. continue. end.  NB. were collisions - re-run
    if. *./,(pp<:|p)*.((v=0)+.(*p)=*v)*.(a=0)+.(*v)=*a do. break. end.
  end.
  #p
)
exit 0

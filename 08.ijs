t=: cutLF CR-.~fread '08.dat'
u=: rplc&('-';'_';'< ';'[=';'> ';']=') NB. replace ops for easier processing

c=: (;:&u&>)"0 t  NB. all commands parsed

id2num=: 30#._96+a.i.] NB. convert string to a number - to easier deal with ids

r=: 2 1$0 NB. regs: top row - ids, bottom row - values. init with dummy entry for correct search

find=: 3 : 0 NB. find reg index; add reg with value if not found
  f=.({.r)i.n=.id2num y
  if. f={:$r do. r=:r,.n,0 end.
  f
)

get=: 3 : 0 NB. get value of reg
  n=.find y
  n{{:r
)

inc=: 4 : 0 NB. increment value of reg
  i=.<1,find y
  r=:(z=.x+i{r)i}r
  z
)

g=: 0 NB. global maximum (assume it will be >0)

exe=: 3 : 0 NB. execute one command
  'cr co cv'=. 4 5 7{y NB. condition reg-name,op,value
  'rr ro rv'=. 3{.y    NB. register reg-name,op,value
  if. (get cr) (=`~:`<`<:`>`>:)@.('=![<]>'i.co) ".cv do. NB. execute condition
    g=: g >. ((".rv) * <:+:'i'={.ro) inc rr NB. modify register, watch maximum
  end. a: NB. always return something of the same type indep. on condition
)

exe"1 c

echo >./{:r NB. part 1 - current max - 5075
echo g      NB. part 2 - global max  - 7310

exit 0

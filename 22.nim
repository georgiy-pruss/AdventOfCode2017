import sets,sequtils,strutils

type Dir = enum W,N,E,S
type PD = object
  p: (int,int)
  d: Dir

proc turn_back( o: var PD ) = (o.d = array[Dir,Dir]([E,S,W,N])[o.d])
proc turn_left( o: var PD ) = (o.d = array[Dir,Dir]([S,W,N,E])[o.d])
proc turn_rght( o: var PD ) = (o.d = array[Dir,Dir]([N,E,S,W])[o.d])

proc advance( o: var PD ) =
  if o.d==W: dec o.p[0] elif o.d==E: inc o.p[0]
  if o.d==N: dec o.p[1] elif o.d==S: inc o.p[1]

var cnt = 0
var infected = initSet[(int,int)]()
var wk_or_fl = initSet[(int,int)]() # if clean: weakened, if infected: flagged

proc move( o: var PD ) =
  if o.p in infected: o.turn_rght(); infected.excl o.p
  else:               o.turn_left(); infected.incl o.p; inc cnt
  o.advance()

proc move2( o: var PD ) =
  if o.p in infected:
    if o.p in wk_or_fl: o.turn_back(); wk_or_fl.excl o.p; infected.excl o.p
    else:               o.turn_rght(); wk_or_fl.incl o.p
  else: # clean
    if o.p in wk_or_fl: #[ no turn ]#  wk_or_fl.excl o.p; infected.incl o.p; inc cnt
    else:               o.turn_left(); wk_or_fl.incl o.p
  o.advance()

var nr,nc = 0 # number of rows, columns
for line in splitLines strip readFile"22.dat":
  for x,c in line:
    if c=='#': infected.incl( (x,nr) )
  nc = line.len
  inc nr
var p = PD( p:(nc div 2,nr div 2), d:N )

var p2 = p # copy for part 2
let infected2 = infected # copy for part 2
for i in 1..10000:
  p.move()
echo cnt # 5450

# part 2
infected = infected2 # restart
cnt = 0
import times
var t0 = epochTime()
for i in 1..10_000_000:
  p2.move2()
echo cnt # 2511957, 2.15s
echo formatFloat( epochTime()-t0, ffDecimal, 3 )


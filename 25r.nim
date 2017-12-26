# version with reading and parsing input
import strutils,sequtils

const NSTEPS = 12481997
const NTAPE = 10000 # shorter tape is enough although it'd work with NSTEPS too

var tape: array[-NTAPE..NTAPE,char] # array of '0' and '1'
var pos: int = 0 # current position in the tape
var state: char  # current state

var writes: array['0'..'1',array['A'..'F','0'..'1']] # what write to tape
var moves:  array['0'..'1',array['A'..'F',-1 .. +1]] # where to move (left/right)
var states: array['0'..'1',array['A'..'F','A'..'F']] # next state

for i in tape.low..tape.high: tape[i] = '0' # fill in the tape with zeros

proc f(s,ss:string, c:var char): bool = # find ss in s, return next char if found
  let idx=s.find ss
  if idx>=0: c=s[idx+ss.len]; return true
  return false

var cs,cv:char # current state, current value -- when reading definition file
for line in splitLines strip readFile"25.dat":
  var c:char
  if   f(line,"Begin in state ",c): state = c # remember initial state
  elif f(line,"In state ",c): cs = c
  elif f(line,"If the current value is ",c): cv = c
  elif f(line,"Write the value ",c): writes[cv][cs] = c
  elif f(line,"Move one slot to the ",c): moves[cv][cs] = (if c=='l': -1 else: +1)
  elif f(line,"Continue with state ",c): states[cv][cs] = c

for step in 1..NSTEPS:
  let v = tape[pos]
  tape[pos] = writes[v][state]
  pos += moves[v][state]
  state = states[v][state]

echo foldl( tape, a + ord(b)-ord('0'), 0 )

const NSTEPS = 12481997

var tape: array[-NSTEPS..NSTEPS,int]
var pos: int = 0
# This does not work: const A=0,B=1,C=2,D=3,E=4,F=5
const A=0; const B=1; const C=2; const D=3; const E=4; const F=5
var state: int = A

# This does not work:
# type State = enum A,B,C,D,E,F
# let writes: array[0..1,array[State,0..1]] = [[1,1,0,1,1,1],[0,1,0,0,1,1]]
# let states: array[0..1,array[A..F,int]]   = [[B,A,B,A,F,D],[C,D,E,B,C,A]]
# So I'll have to use ints

let writes: array[0..1,array[A..F,int]] = [[1,1,0,1,1,1],[0,1,0,0,1,1]]
let moves:  array[0..1,array[A..F,int]] = [[+1,-1,-1,+1,-1,+1],[-1,+1,-1,+1,-1,+1]]
let states: array[0..1,array[A..F,int]] = [[B,A,B,A,F,D],[C,D,E,B,C,A]]

# init; pos and state are already set
for i in tape.low..tape.high: tape[i] = 0

# NSTEPS moves
for step in 1..NSTEPS:
  let v = tape[pos]
  tape[pos] = writes[v][state]
  pos += moves[v][state]
  state = states[v][state]

# sum; I can't use foldl here because it would require import sequtils
var sum = 0
for i in tape.low..tape.high: sum += int(tape[i])
echo sum

import strutils,sequtils,tables

type Cmd = enum SR, SI, AR, AI, MI, RR, RI, RCV, SND, JGI, JMP
var regs = newTable[string,int]()
var rname = newSeq[string]()

var pgm: seq[(Cmd,int,int)] = @[]

proc c2i( r:string ):int =
  if r notin regs:
    regs[r] = regs.len
    rname.add r
  return regs[r]

for line in splitLines strip readFile "18.dat":
  let o = split line
  case o[0]:
  of "set":
    if o[2].isAlphaAscii(): pgm.add( (SR,c2i(o[1]),c2i(o[2])) )
    else:                   pgm.add( (SI,c2i(o[1]),parseInt(o[2])) )
  of "add":
    if o[2].isAlphaAscii(): pgm.add( (AR,c2i(o[1]),c2i(o[2])) )
    else:                   pgm.add( (AI,c2i(o[1]),parseInt(o[2])) )
  of "mul":                 pgm.add( (MI,c2i(o[1]),parseInt(o[2])) )
  of "mod":
    if o[2].isAlphaAscii(): pgm.add( (RR,c2i(o[1]),c2i(o[2])) )
    else:                   pgm.add( (RI,c2i(o[1]),parseInt(o[2])) )
  of "snd":                 pgm.add( (SND,c2i(o[1]),0) )
  of "rcv":                 pgm.add( (RCV,c2i(o[1]),0) )
  of "jgz":
    if o[1].isAlphaAscii():
      if o[2]=="p":         pgm.add( (JGI,c2i(o[1]),17) )
      else:                 pgm.add( (JGI,c2i(o[1]),parseInt(o[2])) )
    else:                   pgm.add( (JMP,0,parseInt(o[2])) )
  else:
    raise newException(ValueError,"wrong command")

const REGS=5 # five is enough

type Process = object
  rg: array[REGS,int] # registers
  pc: int # program counter
  id: int # program id - 0 or 1
  ended: bool # ps is out of bounds
  waiting: bool # program is waiting

proc init( p: var Process, id: int ) =
  for i in 0..< REGS: p.rg[i]=0
  p.rg[regs["p"]] = id
  p.pc = 0
  p.id = id
  p.ended = false
  p.waiting = false

var p0,p1: Process

p0.init(0)
p1.init(1)

var q: array[2,seq[int]] = [newSeq[int](),newSeq[int]()] # rcv msg queues, one for each process

var cnt = 0
proc run( p: var Process ):bool =
  # return if something was sent
  var sent = false
  while true:
    let (cmd,op1,op2) = pgm[p.pc]
    p.pc += 1
    case cmd:
    of SR: p.rg[op1] = p.rg[op2]
    of SI: p.rg[op1] = op2
    of AR: p.rg[op1] += p.rg[op2]
    of AI: p.rg[op1] += op2
    of MI: p.rg[op1] *= op2
    of RR: p.rg[op1] = p.rg[op1] mod p.rg[op2]
    of RI: p.rg[op1] = p.rg[op1] mod op2
    of SND:
      q[1-p.id].add p.rg[op1]
      if p.id==1: cnt+=1
      sent = true
    of RCV:
      if q[p.id].len>0:
        p.waiting = false
        p.rg[op1] = q[p.id][0]; q[p.id].delete(0,0)
      else:
        p.pc -= 1 # to run 'rcv' again
        p.waiting = true;
        break
    of JMP: p.pc += op2-1
    of JGI:
      if p.rg[op1]>0: p.pc += op2-1
    else: echo "?",cmd
    if p.pc<0 or p.pc>=pgm.len: p.ended = true; break
  return sent

var sent0 = p0.run()
var sent1 = p1.run()
while not p1.ended:
  if not sent1: break
  sent0 = p0.run()
  if p0.ended: break
  if not sent0: break
  sent1 = p1.run()

echo cnt

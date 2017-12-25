import strutils,sequtils,tables

type Cmd = enum SETR, SETI, SUBR, ADDI, MULR, MULI, JNZI, JMPI

const REGS=8 # actual number of regs
const rname: array[REGS,string] = ["a","b","c","d","e","f","g","h"]

var pgm: seq[(Cmd,int,int)] = @[]

proc c2i( r:string ):int = rname.find r

for line in splitLines strip readFile "23.dat":
  let o = split line
  case o[0]:
  of "set":
    if o[2].isAlphaAscii(): pgm.add( (SETR,c2i(o[1]),c2i(o[2])) )
    else:                   pgm.add( (SETI,c2i(o[1]),parseInt(o[2])) )
  of "sub":
    if o[2].isAlphaAscii(): pgm.add( (SUBR,c2i(o[1]),c2i(o[2])) )
    else:                   pgm.add( (ADDI,c2i(o[1]),-parseInt(o[2])) )
  of "mul":
    if o[2].isAlphaAscii(): pgm.add( (MULR,c2i(o[1]),c2i(o[2])) )
    else:                   pgm.add( (MULI,c2i(o[1]),parseInt(o[2])) )
  of "jnz":
    if o[1].isAlphaAscii(): pgm.add( (JNZI,c2i(o[1]),parseInt(o[2])) )
    else:                   pgm.add( (JMPI,parseInt(o[1]),parseInt(o[2])) )
  else:
    raise newException(ValueError,"wrong command")

proc fmtcmd(x:Cmd,y,z:int):string =
   if x in [SETR,SUBR,MULR]: return $x&" "&rname[y]&"/"& $y&" "&rname[z]&"/"& $z
   elif x!=JMPI:             return $x&" "&rname[y]&"/"& $y&" "& $z
   else: assert y!=0;        return $x&" "& $z

for instr in pgm:
  echo fmtcmd( instr[0],instr[1],instr[2] )

type Process = object
  rg: array[REGS,int] # registers
  pc: int # program counter

proc init( p: var Process ) =
  for i in 0..< REGS: p.rg[i]=0
  p.pc = 0

proc run( p: var Process ):int =
  var cnt = 0
  echo "run ",p.pc
  while p.pc>=0 and p.pc<pgm.len:
    let (cmd,op1,op2) = pgm[p.pc]
    #echo p.pc,"  ",fmtcmd( cmd,op1,op2 )
    p.pc += 1
    case cmd:
    of SETR: p.rg[op1] = p.rg[op2]
    of SETI: p.rg[op1] = op2
    of SUBR: p.rg[op1] -= p.rg[op2]
    of ADDI: p.rg[op1] += op2
    of MULR: p.rg[op1] *= p.rg[op2]; inc cnt
    of MULI: p.rg[op1] *= op2; inc cnt
    of JMPI: p.pc += op2-1
    of JNZI:
      if p.rg[op1]!=0: p.pc += op2-1
    else: echo "?",cmd
  return cnt

var p0: Process
p0.init()
echo p0.run()


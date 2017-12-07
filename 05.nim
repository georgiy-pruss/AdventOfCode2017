import strutils,sequtils
proc run( code_arg: seq[int], part2 = false ): int =
  var code = code_arg # mutable copy
  var pc,cnt = 0
  while pc>=0 and pc<code.len:
    let nextpc = pc + code[pc]
    if part2 and code[pc]>=3: code[pc] -= 1 else: code[pc] += 1
    pc = nextpc; cnt += 1
  return cnt
let code = "05.dat".readFile.strip.splitLines.map parseInt
echo run(code)
echo run(code,true)


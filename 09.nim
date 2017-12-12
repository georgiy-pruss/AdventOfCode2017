var ingrp,gbg,score = 0
var ingbg,ignore = false
for c in readFile"09.dat":
  if ignore: ignore = false; continue
  if c=='{':
    if not ingbg: ingrp += 1 else: gbg += 1
  elif c=='}':
    if not ingbg: score += ingrp; ingrp -= 1 else: gbg += 1
  elif c=='<':
    if ingbg: gbg += 1 else: ingbg = true
  elif c=='>': ingbg = false
  elif c=='!': ignore = true
  elif ingbg: gbg += 1
echo score, ' ', gbg

var h = 0
for b in countup(108_400,108_400+17000,17):
  for d in 2..b div 2:
    if b mod d == 0:
      inc h
      break
echo h

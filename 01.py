code = open("01.dat","rt").read().strip()
lenc = len(code); half = lenc//2
zero = ord('0')
sum = sum2 = 0
for i,c in enumerate(code):
  if c == code[(i+1)%lenc]: sum += ord(c) - zero
  if c == code[(i+half)%lenc]: sum2 += ord(c) - zero
print(sum,sum2)

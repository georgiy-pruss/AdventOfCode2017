from math import sqrt, floor

n = 265149

# Part 1: Distance, calculate

def d( n:int )->int :
  f = int(sqrt(n-1)); h=f//2; q=f%2; g=f*f
  return abs(n-h-1-g-(f+q,0)[n<g+f+2])+h+q

print(d(n))

# Part 2: A141481 http://oeis.org/A141481

def g( z:list, k:int )->list: # generate new part of sequence
  r = [ z[-1][-1] + z[-1][-2] + z[-5][-1] + z[-4][0] ]
  r.append( r[-1] + z[-5][-1] + z[-4][0] + z[-4][1] )
  for i in range(2,k-2):
    r.append( r[-1] + z[-4][i-2] + z[-4][i-1] + z[-4][i] )
  r.append( r[-1] + z[-4][-2] + z[-4][-1] )
  r.append( r[-1] + z[-4][-1] )
  return r

def m( n:int )->int:
  z = [[1],[1],[2],[4,5],[10,11],[23,25,26],[54,57,59]]
  for i in range(4,99):
    for j in (1,2):
      s = g(z,i)
      for x in s:
        if x>n: return x
      z.append(s)

print(m(n))

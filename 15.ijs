G=: g^:(0~:4|])^:_@g=: 2147483647|16807*]
H=: h^:(0~:8|])^:_@h=: 2147483647|48271*]
c=: [:+/0=16bffff(17 b.)[22 b.]
echo (g^:(>:i.N)289)c h^:(>:i.N=:40000000)629
echo (G^:(>:i.N)289)c H^:(>:i.N=:5000000)629
exit 0

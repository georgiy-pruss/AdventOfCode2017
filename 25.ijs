t=:10000#0                                 NB. tape (ring), 10000 is enough
w=:#:3539                                  NB. write: 1 1 0 1 1 1, 0 1 0 0 1 1
m=:1 _1 _1 1 _1 1 _1 1 _1 1 _1 1           NB. move:  R L L R L R, L R L R L R
n=:_65+a.i.'BABAFDCDEBCA'[s=:0             NB. next:  B A B A F D, C D E B C A
f=:3 :'y+v{m[s=:v{n[t=:t y}~w{~v=.s+6*y{t' NB. one move; take pos, return pos
f^:12481997[0                              NB. 12481997 moves with init pos 0
echo +/t                                   NB. finally count 1s in the tape
exit 0                                     NB. approx 15s

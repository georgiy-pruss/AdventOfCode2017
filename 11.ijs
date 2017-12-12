t=: LF-.~CR-.~fread'11.dat'
x=: ". t rplc 'ne';'1';'nw';'2';'sw';'4';'se';'5';'n';'0';'s';'3';',';' '
k=: 6 3$ 1 0 0  0 1 0  0 0 1  _1 0 0  0 _1 0  0 0 _1 NB. n,ne,nw for moves
d=: (+/ - <./)@:| NB. distance fn of 3-element array n,ne,nw
echo d +/x{k      NB. part1 - distance of all moves
echo >./d"1+/\x{k NB. part2 - max of distances of running sum of moves
exit 0

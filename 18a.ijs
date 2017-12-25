r=:v=:'' NB. register names, register values
snd=:0   NB. snd register

rd=:3 :'if.(#r)>p=.r i.y do. p{v else. 0 end.'
wr=:4 :'if.(#r)>p=.r i.y do. v=:x p}v else. r=:r,y [ v=:v,x end.'
id=:3 :'((96&< *. <&123)a.i.{.y)*.1=#y'
ov=:3 :'if.id y do. rd y else. ".y end.'

echo 3 :0 cut&> cutLF CR-.~fread'18.dat'
  pc=.0
  while.(pc>:0)*.pc<#y do.
    'c a b'=: pc{y
    pc=.>:pc
    select. c
    case.'set'do.(ov b)wr a
    case.'add'do.((ov b)+rd a)wr a
    case.'mul'do.((ov b)*rd a)wr a
    case.'mod'do.((ov b)|rd a)wr a
    case.'snd'do.snd=.ov a
    case.'rcv'do.if.ov a do.snd return.end.
    case.'jgz'do.if.0<ov a do.pc=.pc+<:ov b end.
    end.
  end.
)

exit 0

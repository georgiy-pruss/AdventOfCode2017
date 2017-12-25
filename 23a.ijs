r=:8$0 NB. register values
rd=:3 :'r{~_97+a.i.y'
wr=:4 :'r=:x(_97+a.i.y)}r'
id=:3 :'((96&< *. <&105)a.i.{.y)*.1=#y'
ov=:3 :'if.id y do.rd y else.".y end.'
echo 3 :0 cut&> cutLF CR-.~fread'23.dat'
  pc=.n=.0
  while.(pc>:0)*.pc<#y do.
    'c a b'=: pc{y
    pc=.>:pc
    select. c
    case.'set'do.(ov b)wr a
    case.'sub'do.((ov b)-~rd a)wr a
    case.'mul'do.((ov b)*rd a)wr a[n=.>:n
    case.'jnz'do.if.ov a do.pc=.pc+<:ov b end.
    end.
  end.
  n
)
exit 0

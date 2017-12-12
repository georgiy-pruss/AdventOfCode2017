exit 3 : 0 fread'09.dat' NB. no need to remove CR,LF
  n=.p=.i=.g=.s=.0 NB. in garbage, in group, ignore, garbage count, score count
  for_c.y do.
    if.i do.i=.0
    elseif.c='{'do.if.n do.g=.>:g else.p=.>:p end.
    elseif.c='}'do.if.n do.g=.>:g else.p=.<:p[s=.s+p end.
    elseif.c='<'do.if.n do.g=.>:g else.n=.1 end.
    elseif.c='>'do.n=.0
    elseif.c='!'do.i=.1
    elseif.n do.g=.>:g
  end.end.
  echo s,g
)

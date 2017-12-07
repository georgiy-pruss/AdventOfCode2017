m=: ".>cutLF CR-.~fread '05.dat'
echo 3 :'p=.c=.0 while.(p>:0)*.p<#y do.p=.p+j[y=.(>:j=.p{y)p}y[c=.c+1 end.c'm
echo 3 :'p=.c=.0[l=.#y while.(p>:0)*.p<l do.p=.p+j[y=.(j+1-+:3<:j=.p{y)p}y[c=.c+1 end.c'm
exit 0

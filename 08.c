#include <stdio.h>
#include <string.h>

typedef char* S; // this typedef and defines are from _.h
#define C char
#define I int
#define __ {
#define _  }
#define R return
#define DO(_i,_n) for(I _i=0;_i<(_n);++_i)

I cond( I x, I y, S o ) __
  if( *o=='=' ) R x==y; if( *o=='!' ) R x!=y;
  if( *o=='<' ) R o[1]=='=' ? x<=y : x<y;
  if( *o=='>' ) R o[1]=='=' ? x>=y : x>y; _

I nr = 0; C rn[100][4]; I rv[100] = {0}; // registers: num, names, values
I find( S n ) { DO(i,nr) if(!strcmp(rn[i],n)) R i; R -1; }
I newr( S n ) { strcpy(rn[nr],n); rv[nr]=0; R nr++; }

I main() __ I gm = -9999;
  FILE* f = fopen("08.dat","rt"); C l[80];
  while( fgets(l,sizeof(l),f) ) __ C r[4],o[4],cr[4],co[4]; I a,ca;
    sscanf( l, "%s %s %d if %s %s %d\n", r, o, &a, cr, co, &ca );
    I i=find(cr); I cv=i<0?0:rv[i];
    if( cond(cv,ca,co) ) __
      I j=find(r); if(j<0) j=newr(r);
      rv[j] += *o=='i' ? a : -a;
      if(rv[j]>gm) gm=rv[j]; _ _ // update global max
  I m = -9999; DO(i,nr) if(rv[i]>m) m=rv[i]; // find final state max
  printf( "%d\n%d\n", m, gm );
  fclose(f); R 0; _

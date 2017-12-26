import strutils,sequtils
var t:array[-7000..70,char]
var s,z,v,c:char
type S='A'..'F'
type V='0'..'1'
var w:array[V,array[S,V]]
var m:array[V,array[S,-1..1]]
var n:array[V,array[S,S]]
for i in t.low..t.high:t[i]='0'
proc f(s,p:string,c:var char):bool=
 let x=s.find p
 if x>=0:c=s[x+1+p.len];return true
 return false
for i in lines"25.dat":
 if f(i,"n in state",c):s=c
 elif f(i,"In state",c):z=c
 elif f(i,"ot to the",c):m[v][z]=(if c=='r':1 else: -1)
 elif f(i,"ith state",c):n[v][z]=c
 elif f(i," the value",c):w[v][z]=c
 elif f(i,"t value is",c):v=c
var p:int=0
for i in 1..12481997:
 let v=t[p]
 t[p]=w[v][s]
 p+=m[v][s]
 s=n[v][s]
echo foldl(t,a+ord(b)-48,0)

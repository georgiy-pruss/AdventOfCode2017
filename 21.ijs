t=: ('#'&=&.>)"0 cut&> cutLF-.&'/=>'CR-.~fread'21.dat'
m=: (,~<.%:)&#$] NB. make a matrix: v4 | v9 | v16 -> m22 | m33 | m44
n=: #.@(1&,) NB. make a number out of vector
v=: }.@#:    NB. make a vector out of number
g=: [:n"1[:,"2[:(,|."_1)@(,|."1)@(,:|:)m NB. all varians of 1 matrix
'k w'=:|:(#~~:)/:~_2]\,(([:(#~~:)[:g[:>{.),.(n@>@{:))"1 t NB. book of transformations
f=: 3 :',(,./@:>)"1 m&.>"0([:v w{~k i.n@,)&.>(;~(<.%:#y)$1{.~2+2|#y)<;.1 m y' NB. one step
echo +/f^:5 i=:0 1 0 0 0 1 1 1 1 NB. .#./..#/###
s=: 6!:1''
echo +/f^:18 i
echo s-~6!:1''
exit 0

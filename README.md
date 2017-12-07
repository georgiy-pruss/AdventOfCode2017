# AdventOfCode2017

<a href="http://adventofcode.com/">Advent of code 2017</a> - AoC 2017 in J and Nim, maybe Python.

<table border=1 cellspacing=0 cellpadding=3>
<thead>
<tr>
<td>Day</td><td>Title</td>
<td>Text</td><td>Data</td><td>J</td><td>Nim</td><td>Rem</td>
</tr>
</thead>
<tbody>
<tr>
<td><a href="https://www.reddit.com/r/adventofcode/comments/7gsrc2/2017_day_1_solutions/">01</a></td>
<td><a href="http://adventofcode.com/2017/day/1">Inverse Captcha</a></td>
<td><a href="01.txt">3050</a></td><td><a href="01.dat">2010</a></td>
<td><a href="01.ijs">88</a></td><td><a href="01.nim">287</a></td><td><a href="01.py">260</a></td>
</tr>
<tr>
<td><a href="https://www.reddit.com/r/adventofcode/comments/7h0rnm/2017_day_2_solutions/">02</a></td>
<td><a href="http://adventofcode.com/2017/day/2">Corruption Checksum</a></td>
<td><a href="02.txt">2261</a></td><td><a href="02.dat">1118</a></td>
<td><a href="02.ijs">112</a></td><td><a href="02.nim">301</a></td><td>&nbsp;</td>
</tr>
<tr>
<td><a href="https://www.reddit.com/r/adventofcode/comments/7h7ufl/2017_day_3_solutions/">03</a></td>
<td><a href="http://adventofcode.com/2017/day/3">Spiral Memory: A214526/A141481</a></td>
<td><a href="03.txt">2497</a></td><td>265149</td>
<td><a href="03.ijs">448</a></td><td><a href="03.nim">891</a></td><td><a href="03.py">716</a></td>
</tr>
<tr>
<td><a href="https://www.reddit.com/r/adventofcode/comments/7hf5xb/2017_day_4_solutions/">04</a></td>
<td><a href="http://adventofcode.com/2017/day/4">High-Entropy Passphrases</a></td>
<td><a href="04.txt">1453</a></td><td><a href="04.dat">23863</a></td>
<td><a href="04.ijs">108</a></td><td><a href="04.nim">518</a></td><td>&nbsp;</td>
</tr>
<tr>
<td><a href="https://www.reddit.com/r/adventofcode/comments/7hngbn/2017_day_5_solutions/">05</a></td>
<td><a href="http://adventofcode.com/2017/day/5">A Maze of Twisty Trampolines, All Alike</a></td>
<td><a href="05.txt">2249</a></td><td><a href="05.dat">5764</a></td>
<td><a href="05.ijs">212</a></td><td><a href="05.nim">405</a></td><td>&nbsp;</td>
</tr>
<tr>
<td><a href="https://www.reddit.com/r/adventofcode/comments/7hvtoq/2017_day_6_solutions/">06</a></td>
<td><a href="http://adventofcode.com/2017/day/6">Memory Reallocation</a></td>
<td><a href="06.txt">2952</a></td><td><a href="06.dat">37</a></td>
<td><a href="06.ijs">195</a></td><td><a href="06.nim">487</a></td><td>&nbsp;</td>
</tr>
</tbody>
<tfoot>
<!--
(+/%#) 3050 2261 2497 1453 2249 2952
(+/%#) 2010 1118 6 23863 5764 37
(+/%#) 88 112 448 108 212 195
(+/%#) 287 301 891 518 405 487
-->
<tr>
<td>&nbsp;</td><td align=right>Mean:</td><td>2410</td><td>5466</td><td>194</td><td>484</td>
<td><i>2.48</i></td>
</tr>
</tfoot>

</table>

Sorry you'll have to rename nim programs — nim can't deal with names made of digits only.

Meanwhile, other warts of Nim discovered:

* No % and // ops, only mod and div. Aha, there's %%. Where then //? Where?  
* Other ops... we'll see. Documentation on expressions is absent.  
* Parameters are const. WTF! I have to create a mutual copy not only for complex data, but even for ints!  
* discard is disgusting. Why not skip?  
* incl for sets must be add.  
* No 'loop', again stupid 'while true'. GSD not True.  
* Not sure about @[] vs [] yet.  



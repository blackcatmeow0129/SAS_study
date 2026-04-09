/* 4장 실습문제 */

/* 4.1 */
data stat2.exam4_11;
input hight wight;
cards;
152 48
156 47
163 54
165 57
166 53
168 55
170 62
172 67
173 72
174 70
176 78
177 76
;
run;
proc print data = stat2.exam4_11;
run;


proc sort data = stat2.exam4_11 out = stat2.exam4_12;
	by descending wight;
proc print data = stat2.exam4_12;
run;


/* 4.2 */

proc plot data=stat2.exam4_12;
	plot hight*wight='o';
run;


/* 4.3 */

symbol1 v=circle c=blue i=rl l=1; 
symbol2 v=star c=red i=rl l=2; 

proc gplot data=stat2.class1;
	 plot eng*iq1 math*iq1 / overlay;
run;




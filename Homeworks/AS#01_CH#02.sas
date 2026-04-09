/* 연습문제 2.1 */

data stat2.exam2_11;
input id gender$ mid final;
cards;

2002001 M 78 88
2002002 F 75 80
2002003 F 86 79
2002004 M 92 88
2002005 M 88 93
2002006 F 67 90
2002007 M 86 77
2002008 M 80 87
2002009 F 95 86
2002010 M 79 90
;
proc print data=stat2.exam2_11; 
run;


data stat2.exam2_12;
infile '/home/u64470274/sasuser.v94/data_file/score1.txt';
input id gender$ mid final;
run;
proc print data=stat2.exam2_12;
run;

proc import 
		out = stat2.exam2_13
		datafile ='/home/u64470274/sasuser.v94/data_file/score1.xlsx'
		dbms=xlsx
		replace;
		getnames=yes;
	run;
proc print data = stat2.exam2_13;
run;


/* 연습문제 실습 2.2 */

data stat2.exam2_2;
infile '/home/u64470274/sasuser.v94/data_file/score2.txt';
input id gender $ mid final @@ ;
run;
proc print data=stat2.exam2_2;
run;


/* 연습문제 2.3 */

data stat2.exam2_3;
infile '/home/u64470274/sasuser.v94/data_file/score3.txt'; 
input id 7. gender $ 1. mid 2. final 2.;
run;
proc print data=stat2.exam2_3;
run;

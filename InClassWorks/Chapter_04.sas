/* sas 기본 proc */


/*
1. PROC PRINT
proc print data=세스 데이타이름;
var 변수명; : 특정 변수만 출력하고 싶을때
*/

proc print data=stat2.class1;
	var class name gender reg;
run; 



/*
2. PROC SORT : 오름차순
proc sort data=원래 세스 데이터 이름 OUT 새로운 세스 데이터 이름 ;
by descending 변수명1 descending 변수명2 변수명3 : 내림차순으로 정렬하기 (디폴트는 오름차순) 우선순위는 왼쪽부터 

*/


proc sort data=stat2.class2 out=fa;
	by iq1 descending reg name;
run;
proc print data=fa;
	var class name iq1 reg;
run;


/*
3. PROC PLOT : 그래프 그려라 (scater plot : 두변수가 무슨 관계가 있나?)
proc plot data = 세스 데이터;
plot 변수명1*변수명2/haxis = a to b by c 
					vaxi= d to e by f;

plot 변수명*(변수명2 변수명3)='기호또는 변수명'

plot 변수명1*변수명2='기호' 변수명1*변수명3='기호'
overlay;

run;

*/

proc plot data=stat2.class;
	plot eng*math='*'
		/vaxis = 60 to 95 by 5 /*ENG*/
		 haxis = 60 to 95 by 5; /*MATH*/
run;




proc plot data=stat2.class;
	plot iq1*eng='o' iq1*math='*'
	 	/overlay vaxis = 95 to 145 by 5
	 			 haxis = 60 to 95 by 5;
run;

/*
4. GPLOT : 좀 더 성의있는 그래프가 그려짐
symbol1 옵션
symbol2 옵션

symboln 옵션;
proc gplot data=세스 데이터 이름;
plot 변수명1*변수명2;
(RUN 안넣어도 출력 되는듯 : 그래서 run넣으면 두개나옴)
*/

symbol I=R V=star H=2 W=2;
proc gplot data=stat2.class;
	plot eng*math;


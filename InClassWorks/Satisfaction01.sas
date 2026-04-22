/* 자료 가공하기 */
data test2;
infile '/home/u64470274/sasuser.v94/만족도.txt';
input  id b1-b6 w1-w5 p1-p5 sat q1 q2 gender age q3 year month ;
 if age=99 then age=.;
 ARRAY test b1-b6 w1-w5 p1-p5 sat gender;
	DO over test;
	IF test = 9 THEN test = .;
	END;

run;
proc print data=test2;
run;
/* 결측치는 .으로 바꿔야함 : 그래야 분석할 수 있음 */

proc means data=test2;
run;


data test2_1;
set test2;

b=mean(b1, b2, b3, b4, b5, b6);
bb=(b1+b2+b3+b4+b5+b6)/6;
w=mean(w1, w2, w3, w4, w5);
ww=(w1+w2+w3+w4+w5)/5;
keep b1-b6 b bb w1-w5 w ww;
proc print data=test2_1;
run;



proc univariate data=test2_1;
var bb ww;
run;

proc freq data=test2;
tables gender sat;
run;


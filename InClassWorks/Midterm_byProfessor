/* 중간고사 문제풀이 : ~5번까지는 기말고사에도 나옴 */

/* 중간고사 피드백
문제풀때를 제외한 원본 데이타를 기억할것 (문제에서 풀면 데이터가 훼손될 수 있음)
양측검정은 나누기 2
귀무가설은 무조건 긍정문 '~이다' : 헷갈리지 말것
 */

data test0;
infile '/home/u64470274/sasuser.v94/Datafile/장애인복지만족도.txt';
input id gender age edu year month a1-a5 b1-b5 c1-c5 sat v11 v12;

array q a1-a5 b1-b5 c1-c5 sat v11 v12 gender;
do over q;
	if q=9 then q=.;
	end;
run;

proc print data=test0;
run;

/* 1 */

data test1;
set test0;
aa=(a1+a2+a3+a4+a5)/5;
bb=(b1+b2+b3+b4+b5)/5;
cc=(c1+c2+c3+c4+c5)/5;
run;
proc print data=test1;
run;

proc univariate data=test1;
run;


/* 2 */

data test2;
set test1;

tot=year*12+month;
if tot=0 then tot_ci=.;
if tot>=120 then tot_ci=4;
else if tot>=84 then tot_ci=3;
else if tot>=48 then tot_ci=2;
else if tot>=1 then tot_ci=1;
else tot_ci=.; *나는 이거 안함 ㅠㅠ;
run;


proc freq data=test2;
	tables tot_ci;
run;


/* 3 */

data test3;
set test2;

if age>=40 then n_age=4;
else if age>=30 then n_age=3;
else if age>=20 then n_age=2;
else n_age=.;

if edu>=3;
run;

proc freq data=test3;
	tables n_age;
run;

/* 4 */

proc freq data=test4;
	tables n_age*tot_ci/ norow nocol;
run;


/* 5 */

data test5;
set test2;

if bb>=5 then bb1=3;
else if bb>3 then bb1=2;
else if bb>0 then bb1=1;
else bb1=.;
run;

proc freq data=test5;
tables gender*bb1/nocol nopercent;
run;



/* 2026/04/27 월요일 교수님 중간고사 문제풀이 영상보기 놓침 ㅎㅎ */

data test0;
infile '/home/u64470274/sasuser.v94/Datafile/장애인복지만족도.txt';
input id gender age edu year month a1-a5 b1-b5 c1-c5 sat v11 v12;

if gender=9 then gender=.;
if a1=9 then a1=.;
if a2=9 then a2=.;
if a3=9 then a3=.;
if a4=9 then a4=.;
if a5=9 then a5=.;

if b1=9 then b1=.;
if b2=9 then b2=.;
if b3=9 then b3=.;
if b4=9 then b4=.;
if b5=9 then b5=.;

if c1=9 then c1=.;
if c2=9 then c2=.;
if c3=9 then c3=.;
if c4=9 then c4=.;
if c5=9 then c5=.;

if sat=9 then sat=.;

if v11=9 then v11=.;
if v12=9 then v12=.;
run;


/* 1 */

data test1;
set test0;


aa=(a1+a2+a3+a4+a5)/5;
bb=(b1+b2+b3+b4+b5)/5;
cc=(c1+c2+c3+c4+c5)/5;
run;

proc univariate data=test1(keep=aa bb cc);
run;


/* 2 */

data test2;
set test1;

tot = 12*year + month;

if tot=0 then tot_ci=.;
	else if tot>=10*12 then tot_ci=4;
	else if tot>=7*12 then tot_ci=3;
	else if tot>=4*12 then tot_ci=2;
	else tot_ci=1;
run;


proc freq data=test2;
	tables tot_ci;
run;


/* 3 */

data test3;
set test2;

if edu>=3;
if age>=40 then N_age=3;
	else if age>=30 then N_age=2;
	else if age>=20 then N_age=1;
	else N_age=.;
run;

proc freq data=test3;
	tables N_age;
run;


/* 4 */
data test4;
set test3;


proc freq data=test4;
	tables N_age*tot_ci;
run;


/* 5*/

data test5;
set test4;

if bb>=5 then bb1=3;
	else if 3<bb<5then bb1=2;
	else if bb<=3 then bb1=1;
	else bb1=.;
run;

proc freq data=test5;
	tables gender*bb1;
run;


/* 6 */
data test6;
set test5;
keep age gender aa edu;
run;

proc means data=test6 p30 ;
var aa;
run;

data test6;
set test5;
if aa<=4.8;
keep age gender aa edu;
run;


/* 7 */

data test7;
set test5;

if edu=3;
keep tot id aa ;
run;


/* 8 */

data test8;
set test5;

if edu=3;
keep cc id age;
run;

/* 9 */
data test9;
set test5;

if age>=30;
keep bb id tot ;
run;

/* 10 */

data test10;
set test2;

sat_tot=(aa+bb+cc)/3;
run;

proc univariate data=test10;
run;



/* 11 */

data test11;
set test10;
if edu<=2;
run;

proc univariate data=test11 normal;
var sat_tot;
run;




/* 12 */

data test12;
set test11;

run;

proc sort data=test11;
by gender;
run;

proc univariate data=test11 normal plot;
by gender;
var sat_tot;
run;


나 교수님 필기 못했어,,,,



/* 13 */

data test13;
set test10;

proc univariate data=test11 mu0=4.0;
var sat_tot;
run;

proc ttest data=test13 H0=4.0 alpha=0.05;
var sat_tot;
run;

proc ttest data=test10 alpha=0.08;
var sat_tot;
run;

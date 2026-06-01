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



proc glm data=test1;
class edu;
model cc=edu;
means edu /duncan scheffe;
run;

proc corr data=test1;
var aa bb cc;
with sat;
run;

/* 하나라도 값이 없으면 통계에 사용하지 않음.  */
data t1;
set test1;
if sat =. or aa=. or bb=. or cc=. then delete;
run;

proc corr data=t1;
var aa bb cc;
with sat;
run;

data t2;
set test1;
if sat ~= . & aa ~= . & bb ~= . & cc ~= .;
run;

proc corr data=t2;
var aa bb cc;
with sat;
run;


data test4;
set test1;
if 0 < year*12+month < 7*12 then year_n = 1;
else if year*12+month > 10*12 then year_n=3;
else year_n=.;
run;

proc test4


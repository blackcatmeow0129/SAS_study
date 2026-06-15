data test;
infile '/home/u64470274/sasuser.v94/Datafile/장애인복지만족도.txt';
input id gender age edu year month a1-a5 b1-b5 c1-c5 sat v11 v12;

array q gender age a1-a5 b1-b5 c1-c5 sat v11 v12;
do over q;
if q=9 then q=1;
end;

aa=(a1+a2+a3+a4+a5)/5;
bb=(b1+b2+b3+b4+b5)/5;
cc=(c1+c2+c3+c4+c5)/5;

run;

/* 1 */
proc univariate data=test normal;
var aa bb cc;
run;

/* 2 */
data test1;
set test;
tot = 12*year + month;
if tot=0 then tyear=.;
if tot <4*12 then tyear=1;
else if tot<7*12 then tyear=2;
else if tot<10*12 then tyear=3;
else if tot>=10*12 then tyear=4;
else tyear=.;
run;


proc freq data=test1;
table tyear;
run;

/* 3 */

proc corr data=test nomiss nocorr alpha;
var a1-a5;
run;


proc corr data=test nomiss nocorr alpha;
var b1-b5;
run;

proc corr data=test nomiss nocorr alpha;
var c1-c5;
run;

/* 4 */
data r1;
set test1;
if tot<=1*12 then rr=1;
else if tot>120 then rr=2;
else rr=.;
run;

proc ttest data=r1;
class rr;
var aa;
run;



/* 5 */
proc glm data=test1;
class edu;
model cc=edu;
means edu / duncan scheffe;
run;


/* 6 */
data q6;
set test1;
if sat=. or aa=. or bb=. or cc=. then delete;
run;

proc corr data=q6;
var aa bb cc;
with sat;
run;


/* 7 */
proc reg data=test1;
model sat=bb;
run;


proc reg data=test1;
model sat=aa bb cc age tyear / r p stb;
run;



/* 8 */

data paired;
input id a b;
diff = a-b; /*이게 중요함!!! */
cards;
1 3.8 2.9
2 3.4 3.9
3 3.2 4.3
4 4 3.7
5 3.8 4.5
6 4.1 4.9
7 2.9 4.3
8 5 5.1
;
run;

proc ttest data=paired;
paired a*b;
run;

proc univariate data=paired;
var diff;
run;

proc ttest
























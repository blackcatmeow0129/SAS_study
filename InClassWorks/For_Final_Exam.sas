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
aa=(a1+a2+a3+a4+a5)/5; /*의료만족도*/
bb=(b1+b2+b3+b4+b5)/5; /*교육만족도*/
cc=(c1+c2+c3+c4+c5)/5; /*경제만족도*/
tot_mean=(aa+bb+cc)/3; /* 전체만족도*/
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

tot=year*12+month;
if tot=0 then tot=.;
if 0 < tot <= 7*12 then tot_i = 1;
else if tot >= 10*12 then tot_i =2;
else tot_i=.;
run;

proc ttest data=test4;
class tot_i;
var aa;
run;


/*  
등분산 검정에서 (f)값은 (1.07)이고, 유의확률은 (0.7154)이므므로 등분산을 만족한다. 
검정통계량 (t)값ㄴ은 (-3.34)이고, 유의확률은 (0.001)이다. 
다유의확률이 유의수준보다(작으)므로 로귀무가설을 (기각)한ㄷ다.
그러므로, 장애기간이 7년 이하인 집단과 10년이상인 집단간에 의료만족도가 (ㄷㅏ르다)고 할 수 있다. 

*/



/*  
[7번문제]
교육 만족도가 복지만족도에 영향을 미친다는 주장을 단수선형회귀분석을 통해 유의수준 5%에서 거설을 검정하시오.

귀무 : 교육만족도가 복지만족도에 영향을 미치지 않는다.
대립 : 교육만족도가 복지만족도에 영향을 미친다. 
유의수준 5% 

=> t검정의 결과를 써야함 (f결과말고!)
*/

proc reg data=test1;
model sat=bb;
run;


/*  
검정통계량 (t)값은 (6.93)이고, 고유의확률은 (0.0001)이다. 
유의확률이 유의수준5%보다 작으므로 귀무가설을 기각한다. 
그러므로 교육만족도는 복지만족도에 영향을 미친다고 할 수 있다.

*/



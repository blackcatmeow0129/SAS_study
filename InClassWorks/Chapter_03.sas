*SET문 : 새로운 데이터 파일 만들기 케이스 추가
아래에 냅다 붙임...

[기본 코드]
data 새로운 sas파일명;*
	set 존재하는 sas 파일명1 sas파일명2 sas파일명3**
	run;

 data new;
 	set stat2.exam1;
 run;
 proc print data=new;
 run;
 
 data one;
 	set stat2.exam1 stat2.exam3;
 run;
 proc print data=one;
 run;
 
 


*MERGE문 : 두개이상의 파일을 합치는것! 관측치수는 같고, 변수만 추가됨. (그래서 기준변수가 있어야함)

여기에 short를 넣어야함 : 이게 있어야함! 정렬시켜야해ㅐㅐ
DATA 새로운 sas파일명;*
merge 존재하는 sas파일명1 sas파일명2;*
By 변수명;*
Run;

/* 1반 */
proc sort data=stat2.exam1; by id; run; *아이디 순으로 오름차순정렬 : 출력창에 나타나지 않은 아이임;
proc sort data=stat2.exam2; by id; run; 
/* proc sort data=stat2.exam1; by name; run; *이름기준 오름차순; */
/* proc sort data=stat2.exam2; by name; run; */

data stat2.class1;
merge stat2.exam1 stat2.exam2;
by id;
run;
proc print data=stat2.class1;
run;


/* 2반 */
proc sort data=stat2.exam3; by id; run;
proc sort data=stat2.exam4; by id; run; 

data stat2.class2;
merge stat2.exam3 stat2.exam4;
by id;
run;
proc print data=stat2.class2;
run;


/* 1반+2반 */

 data stat2.class;
 	set stat2.class1 stat2.class2;
 run;
 proc print data=stat2.class;
 run;




/* KEEP 명령어  : 원하는 데이터만 골라서 담음 */*

(1)  
DATA 새로운 파일명;*
SET SAS파일명1;*
KEEP 포함하고자하는 변수명 리스트;*
RUN; *

(2)
DATA 새로운 파일명
(KEEP = 포함하고자하는 변수명 리스트 : ','없이! )
SET 파일명1;*
RUN;


/* 실습 (위 아래 코드는 같은 의미)*/

DATA AA;
SET stat2.exam1;
keep class id name reg;
run;
proc print data=AA;
run;


data aa(keep = class id name reg);
set stat2.exam2;
run;
proc print data = aa;]
run;





/* DROP 명령어 (keep이랑 반대)*/*

(1)  
DATA 새로운 파일명;*
SET SAS파일명1;*
drop고자하는 변수명 리스트;*
RUN; *

(2)
DATA 새로운 파일명
(drop = 포함하고자하는 변수명 리스트 : ','없이! )
SET 파일명1;*
RUN;

*(1);
DATA bb;
SET stat2.exam1;
	drop age reg;
run;
proc print data=bb;
run;

*(2);
data bb1(drop = age reg);
set stat2.exam1;
run;
proc print data=bb1;
run;



/* 기본 if 문 : if 조건이 참일 때, 뒤에거 실행, 아니면, 다음으로 넘어감!*/


/* data cc; */
/* 	set class1; */
/* 		if dept='통계'then math1=math+5; */
/* 			else math1=math; */
/* run; */
/* data cc1(keep=name dept math math1); */
/* 	set cc; */
/* run; */
/* proc print data=cc1; */
/* run; */

/* => 이거 해석 : dept가 통계라면, math에 +5점을 한다. 그런데 새로운 변수 math1에 저장한다. 그런데 만약 통계가 아니라면 점수를 그대로 저장한다. */
/* 새로운 변수를 만들어야 원본에 영향을 안주고 비교할 수 있어서 좋음 */



data cc;
	set stat2.class1;
		if dept='통계' then math1=math+5;
			else math1=math;
run;
data cc1(keep=name dept math math1);
	set work.cc;
run;

proc print data=cc;
proc print data=cc1;
run;


/* then이 없는 if문 : if가 true 인 자료들만 모은다는 이야기*/
data male;
	set stat2.exam1;
		if gender='M';
run;
proc print data=male;
run;

data female;
	set stat2.exam1;
		if gender='F';
run;
proc print data=female;
run;



/* if문 & output문 : if에 해당 안하면 output 밖으로 데이터를 넘겨서 별도로 저장.*/


data kwang seoul country;
	set stat2.exam1;
		if reg='광역시' then output kwang;
			else if reg='서울' then output seoul;
			else output country;
	run;
	proc print data=kwang; run;
	proc print data=seoul; run;
	proc print data=country; run;
	
	


data male1 female1;
	set stat2.exam1;
		if gender='M' then output male1;
			else output female1;
	run;
	proc print data=male1; run;
	proc print data=female1; run;




data female2;
	set stat2.class(keep=gender dept name);
		if gender='F';
		run;
proc print data=female2; run;






/* sas 연산자  */
data dd;
	set stat2.class2;
	total = math+eng;
	average = total/2;
proc print data = dd;
run;

data dd1(keep=name math eng total average);
	set dd;
run;
proc print data = dd1;
run;


/* 부등호 연산자 */
data ee;
set stat2.class1;
if iq1<iq2 then effect='yes';
	else effect='No';
run;

data ee1(keep = name iq1 iq2 effect);
SET ee;
RUN;
proc print data = ee;
PROC PRINT DAtA = ee1;
RUN;



data ff;
set stat2.dd;
m_m = 83.2;
e_m = 81.35;
a = math> m_m & eng >e_m;
proc print data = dd;
run;

data ff1(keep = nane math eng a id);
set ff;
if a=1;
run;
proc print data = ff;
proc print data = ff1;
run;




data ee2;
	set ee ( keep = id name effect );
	if effect = 'yes'; /*내부의 값은 대소문자를 구분함 */
run;

proc print data = ee;
proc print data = ee2;



/* 산술함수 : 데이터에서만 연산됨. 횡끼리만 해줌*/

/* ABS(a) : a의 절댓값 */
/* MAX / MIN : 최대 최저 */
/* MOD(a,b) : a를 b로 나눈 나머지 */
/* SIGN(a) : a가 양수면 +1, 음수면 -1 */
/* SQRT(a) : a의 제곱근  */


data f2_5;
x1 = abs(-3.5);
x2 = max(1,3,5);
x3 = min(10,20);
x4 = mod(15,4);
x5 = sign(-3.14);
x6 = sqrt(49);
run;
proc print data = f2_5;
run;


data gg;
set ee;
math_eng_max = max(math, eng);
keep id name math eng math_eng_max;
run;
proc print data = gg;
run;

/* 얘는 각 변수별 통계량을 알려줌 */
proc means data = gg;
run;

proc means data = gg;
var math eng; *수학과 영어에서만! 돌려줘라는 뜻 (variable);
run;




/* 절단함수 : 원하는 기준으로 나눠주는 함수

CEIL(b) : b보다 같거나 큰 가장 작은 정수
FLOOR(b) : b보다 같거나 작은 가장 큰 정수 
INT(b) : b의 정수부분의 값
ROUND(b,단위) b의 값을 반올림하여 주어진 단위까지 표시 
아래는 데이터 4개, 관측값은 1개 (데이터*/


data f2_6;
y1=ceil(3.58);
y2=floor(-5.4);
y3=int(-1.58);
y4=round(132.46,0.1);
run;
proc print data=f2_6;
run;



/* SAS 연산자 수학함수

EXP(c) : 지수승 (E^c)
GAMMA(c) : c의 감마 함수
LOG(c) : c의 자연로그
LOG10(c) : c의 상용로그  */


data f2_7;
z1=exp(1);
z2=gamma(4);
z3=log(10);
z4=log10(100);
run;
proc print data=f2_7;
run;




/* 삼각함수 

COS(d) : d의 코사인
SIN(d) : d의 사인
TAN(d) : d의 탄젠트 */


data f2_8;
pi=3.141592654;
w1=cos(pi/3);
w2=sin(pi/3);
w3=tan(pi/3);
run;
proc print data=f2_8;
run;


/*  표본 통계량 (모집단일때와 표본일떄의 계산이 달라짐! 구분해서 해야함)
 KEEP과는 다르게 ','가 들어감
 

MEAN(e1,e2) : e1,e2의 평균
SUM(e1,e2) : e1,e2의 합
STD(e1,e2) : e1,e2의 표준편차 (분산에 루트씌운거)
VAR(e1,e2) : e1,e2의 분산 (표준편차 제곱한거)
CV(e1,e2) : e1,e2의 변동계수 (표준편차/평균 = CV = STP/MEAN*100을 함_sas는 100을 곱함!!)
RANGE(e1,e2) : e1,e2 범위 (최대-최소)
STDERR(e1,e2) : e1,e2의 표준에 대한 오차 (STD나누기 루트씌운 데이터 개수(여기서는 n-1))
KURTOSIS(e1,e2) : e1,e2의 첨도 (얼마나 밀집되어 있는가? 첨도가 양수: 뽀족, 첨도가 음수:넙적, 첨도가 0:정규분포표)
SKEWNESS(e1,e2) : e1,e2의 왜도 (얼마나 골고루 분포되어있는가? 얼마나 비대칭적이지? 외도가 0이면 대칭, 왜도도가 0보다 크면 오른쪽꼬리가 길고, 왜도가 0보다 작으면 왼쪽꼬리가 길당) */



data f2_9;
v1=mean(1,2,3,4,5);
v2=sum(1,2,3,4,5);
v3=STD(1,2,3,4,5);
v4=var(1,2,3,4,5);
v5=cv(1,2,3,4,5);
v6=range(1,2,3,4,5);
v7=stderr(1,2,3,4,5);
v8=kurtosis(1,2,3,4,5);
v9=skewness(1,2,3,4,5);
v10_mean=v2/5; *평균구하기;
v11_var=v3**2; *표준편차 제곱;
v12_std=sqrt(v4); *분산 루트;
v13_cv=v3/v1; 
v14_range=max(1,2,3,4,5)-min(1,2,3,4,5); 
keep v1 v2 v3;

run;
proc print data=f2_9;
* var v1 v2 v3 v4 v5;
run;



/* 확률함수 사용형식 : 나중에 할거임
<이산형>
PDF()

<연속형>
PDF('NORMAL', x,y,z) : 평균이y이고 표준편차가z인 정규분포
PDF('T', x, df) : 자유도가 df인 t분포
PDF('chisquare', X, DF)  : 자유도가 df인 카이제곱 분포 */


data f2_16;
	do i=1 to 30;
		x=rand('normal', 75,5 );
		output;
	end;
run;
/* proc print data=f2_16; */
proc means data=f2_16;
var x;
run;

/* 코드분석 : 난수발생 코드

do에서 시작 end에서 끝 (여기서는 30개의 수를 뽑을것이다~를 의미)
i 1에서 시작해서 to30까지 반복
rand : random으로 뽑을거임 (평균이 75이고, 표준편차가 5인곳에서 랜덤으로 뽑음)
output : 이걸 I에 개별로 해서 하나하나 저장시킴
평균 +- 표준편차 : 이 범위안에 68%의 데이터가 있음. 
평균 +- (표준편차)*2 : 이 범위 안에 95.4%의 데이터가 있음
평균 +- (표준편차)*3 : 이 범위 안에 99.9%의 데이터가 있음 
그외 : 이상값임(전체 결과에 영향을 줌 (negative))

*/


/* Uniform 분포 : 일직선 하나(확률이 0혹은 1) */
/* x1=rand('uniform', a, b) : a에서 b까지 (a,b는 포함 안됨) */
data f2_18;
	do I=1 to 30;
		x1=rand('uniform', 0, 1);
		x2=rand('uniform', 5, 10);
		output;
	end;
run;
proc print data=f2_18;
run;
proc means data=f2_18;
run;



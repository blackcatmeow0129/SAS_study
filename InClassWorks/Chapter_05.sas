/* 자료의 정리와 요약 : 기술 통계학*/

/* 
sas를 통계학으로 이용!! 
: 통계학의 구분!!

통계량(표본데이터에서 계산할 수 있는 모든것)과 모수(모집단 데이터로 계산_이걸로 사용)
표본이라고 생각하고!
[대푯값]
평균,중앙값은 1개만 나옴
최빈값은 0개 이상 나올 수 있음
[산포도(자료들이 얼마나 흩어져있는지)]
분산, 표준편차, 변이계수 사분위범위, 범위
: 앞으로는 변수안에서 계산(세로열끼리_이전에는 변수들끼리 비교하고 연산함)



<분산>
편차 = 자룟값 - 평균 , 편차의 합 = 0 (그래서 편차를 제곱해서 평균으로 구함! _ 제곱합의 평균 = 분산)
<표준편차>
그래도 단위를 맞추기 위해 루트를 씌움 = 표준편차
<사분위범위>
Q3-Q1
<범위>
Max-Min
*/

/* [Proc univariate] : 정규성 검정은 얘만 해줌*/
/* 기술 통계량 산출 및 정규성 검정 : 일변량(두개의 변수의 양) 자료에 대한 기술통계량 제공 
대푯값, 산포도, 모수에 대한 신뢰구간및 정규성검정을 위한 정규분포 확률, 상자그림, 히스토그램
*/

/*
Proc univariate data=데이터이름 normal plot;
by 변수명1 변수명2 ;
var 뱐수명1 변수명2 ;
run;

normal : 정규성 검정 : 데이터가 30개가 안되면 
plot : 정규성 검정을 위한 정규확률도, 히스토그램, 상자그림(얘는 이상값을 보여줌)
by : 실행 전에  sort
var : univariate 실행할 변수 리스트



[normal test] {꼭꼭 외우기} : 표본데이터가 30개 이하일때
귀무가설(H0) : 모집단의 분포는 정규분포이다. (알려져 있는 사실_이 용의자는 무죄이다_무죄추정의 원칙)
대립가설(H1) : 모집단의 분포는 정규분포가 아니다. (반대되는 사실_이 용의자는 유죄이다)
유의수준(alpha) : 5% (신뢰수준 95%)_얘를 못믿을 확률(대립가설이라고 말할 확률) (내가 정해둔 기준)

4가지 검정통계량 {검정 통계량은 Shapiro-wilk, 검정통계량값은 숫자로 적기} 유의확률(P) : 표본데이터로 생길 오류의 확률(데이터로 생긴 오류율)
Shapiro-wilk를 이용한 (표본이 2000개 이하)
Kolmogorov-Smirnov (표본이 2000개 이상)


P가 유의수준 alpha 보다 작으면 귀무가설을 기각함(너가 틀림) <-> 귀무가설 채택
*/

/* gender는 by가 필요함, by가 들어갈때는 sort가 by앞으로 꼭 들어가야함. */
Proc sort data=stat2.class out=class_g;
	by gender;
run;
proc univariate data=class_g;
	by gender;
	var iq1;
run;
/* 시험 어떤 방식으로 보는지 에타에서 찾아보기 */


/* 
class 데이터를 이용하여 iq1이 130이상인 여학생에 대해 iq1의 기술통계량을 구하시오
*/


data newone;
set stat2.class;
	if gender='F' & iq1>=130;
RUN;

proc univariate data=newone;
	var iq1;
run;







/* 정규성 검정 */
/*
PROC UNIVARIATE DATA=class NORMAL PLOT;
	VAR math ENG;
RUN;

데이터의 개수가 적으므로 검정결과 확인 
유의수준 알파는 5%=0.05, 유의확률은 0.2940이므로 유의확률이 유의수준보다 크므로 귀무가설을 기각할 수 없다.
그러므로 수학점수 모집단의 분포는 정규분포라고 할 수 있다.


데이터의 개수가 적으므로 검정결과 확인 
알파는 5%=0.05, 유의확률은 @@@이므로 유의확률이 유의수준보다 크므로 귀무가설을 기각할 수 없다.
그러므로 수학점수 모집단의 분포는 정규분포라고 할 수 있다

*/


proc univariate data=stat2.class normal plot;
var math eng;
run;



/* 정규성 검정 MEANS*/
/*
: 위랑 같은데, 정규성 검정은 안해주고 지정해야만 줌, SAS데이터 셋에 저장도 해줌 
PROC MEANS DATA=SAS DATA NAME 통계량 키워드 
CLASS 변수명1 변수명2;
VAR 변수명1 변수명2;
OUTPUT OUT=NEW DATA NAMR {최종 저장은 여기다가함}
통계량 키워드(변수명)=이름;
RUN;


[통계량키워드들]
CLM : 통계에 대한 신뢰구간
RNAGE : 범위
SKEWNESS(SKEW) : 왜도
kurtosis : 첨도
NMISS : 결측개수 NUM의 개수
MEDIAN(P50) : 중앙값 P가 
std : 표준편차
CV : 변의계수
*/


Proc means data=stat2.class N mean STD;
	CLASS gender; /*성별로 달라는 것*/
	var math eng iq1;
run;


proc means data=stat2.class N mean std;
	CLASS gender;
	var math;
	output out=class_out 
		N(math)=nn MEAN(math)=math_mean STD(math)=math_std;
run;
proc print data=class_out;
run;


/* n분위수는 n으로 나눠서 한다는 뜻. 그래서 2 십분위수(D)는 분위를 10개로 나눈거중에서 두번째거 : 20백분위수(Q) */
proc means data=stat2.class q1 median q3 p1 p5 p10 p20 p80;
var math;
run;



proc means data=stat2.class p10 p20 p30 p40 p50 p60 p70 p80 p90;
var math;
run;


/* Proc SUMMARY */
/* 
print를 꼭 해야 출력됨. 새로운 데이터셋으로 저장할 수 있음.

Proc summary data=sas data name 통계량 키워드들 ~print;
class 변수명1 변수명2;  그룹별 통계량 출력
var 변수명1 변수명2;  기술통계량을 계산할 변수들
output out=new data name;
통계량 키워드(변수명)=이름;
run;

여기서 0은 전체결과, 1은 가장 뒷쪽에 있는(가장 안쪽의 변수)

*/


Proc summary data=stat2.class mean print;
	class gender reg; /* 성별 지역별_sort 필요 럾음 / by는 sort필요함 */
	var math eng;  /*변수*/
	output out=class_out1 mean(math eng)=; /*변수는 만들지 말아라*/
run;
proc print data=class_out1;
run;




proc summary data=stat2.class mean print;
	class gender reg;
	var math eng;
run;
/* 총 6집단의 출력결과가 뜰것이다. */



proc sort data=stat2.class;
	by gender reg;
run;
proc summary data=stat2.class mean print;
	by gender reg;
	var math eng;
run;
/* 위에는 다 붙어있는데, by는 다 떨어져있음 _ 출력결과 형태가 다름*/


/* 얘는 새로 저장하는것 */
proc summary data=stat2.class mean print;
class gender reg;
var math eng;
output out=class_out1 mean(math eng)=;
run;
proc print data=class_out1;
run;



/*
Proc univariate data=data name;
class 변수명;
var 변수명;
histogram 변수명1 변수명2 / 옵션;
run;
histogram :
/옵션 : Normal(MU=EST sigma=EST) : 표본데이터의 평균과 표준편차를 이용해서 찾아낸 추정값을 찾아서 히스토그램을 그리고, 정규곡선도 함께 넣어라 

*/


Proc univariate data=stat2.class;
class gender;
var math;
histogram math/normal(mu=est sigma=est);
run;


/* 
proc boxplot data=data name;
plot 변수명1*변수명2/옵션;
run;

변수명2는 sort가 되어야함!!!(by가 없어도) 
옵션 : Boxstyle=schematic(skeletal) : 이상값(1.5*IQR)제외한 최대최소 표시
IQR : Q range(Q3-Q1) 
*/



proc sort data=stat2.class out=class_d;
	by dept;
run;

proc boxplot data=class_d;
	plot eng*dept / boxstyle=schematic;
run;


/*
Proc chart data=data name;
vber(Hber) 변수명/옵션; 수직(수평) 막대그래프 작성
run;
관측수=빈도=도수
옵션


아래는 깔끔한거
Proc gchart data=data name;
vber(Hber) 변수명/옵션; 수직(수평) 막대그래프 작성
run;
관측수=빈도=도수
옵션
width= : 막대의 폭
space= : 막대사이의 간격
FREQ= : 
*/

proc chart data=stat2.class;
	hbar reg/discrete;
run;

proc chart data=stat2.class;
	vbar iq1/midpoints=95 to 145 by 10;
run;

proc gchart data=stat2.class;
	vbar iq1/ space=0 width=10;
run;

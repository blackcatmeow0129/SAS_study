/*
단일 모집단에 모평균에 대한 검정
가설검정 : 
통계적 가설검정 : 모집단에 대한 가설을 설정한뒤 표본에 근거하여 그 가설을 기각 또는 채택할 지 결정(귀무가설, 대립가설 )
귀무가설(H0) : 기존에 알려진 사실을 숫자로 표현한,,,기각을 바라고 세우는 가설
대립가설(H1) : 귀무가설의 반대되는 가설, 분석자가 주장하고자 하는 가설

검정 통계량 : *귀무가설*과 대립가설중 어느 하나를 선택할 때 사용되는 통계량
유의수준(ALPHA)에 따라 결정됨(5%~10%) : 귀무가설을 기각함으로 발생되는 오류를 범할 확률의 최대 허용한계

[T test 검정] : 단일 모집단에 모평균에 대한 검정


단일 모집단의 모평균에 대한 검정(일표본 T TEST)
두 모집단의 비교 독립표본 (독립표본 t검정)
주 모집단의 비교 대응표본(관련성이 있음) (대응표본 t검정)


[일표본 검정통계량] : 얘는 t분포를 따름 T ~ t(n-1) : 0을 기준으로 대칭인 두툼한 모양(정규분포에 비해)
H0 : u(모수) = u0(검정값_숫자)

표본(n)을 계속 증가시키면(무한대로 이동시키면) 봉우리는 표준정규분포로 이동함 (봉우리는 위로가고 꼬리는 0을 향해감)

N : 모집단
n : 표본
_
x : 표본 평균
s : 표분산 
n<30(소표본) : S-W test를 해야함 


rktjfrjawjd wjfck
1. 가설검정
2. 검정통계량 유의수준 검정
3. 유의수준 설정
4. 


*/


/*
Proc ttest data=데이터 파일명 H0=숫자 alpha=숫자(0.01~0.1)(기본값은 0.05);
var 변수명;
run;

귀무가설 : 모평균은 80이다.
u : u0 = 80
*/


/* 
[가설검정]
1. 양측 검정 (아래 두개랑 같은 의미임_근데 계산이 약간 달라짐 아래는 나누기 2 해야함.): |t|
	H0 : u=u0
	H1 : u=/u0
2. 우측 검정 : (증가다)
	H0 : u=u0
	H1 : u>u0
3. 좌측 검정 : (감소다)
	H0 : u=u0
	H1 : u<u0


proc univariate로는 일표본 검정만 할 수 있음
proc univariate data=데이타파일명 MU0=숫자 alpha=숫자 CIBASIC;
var 변수명;
run;


시험은 필기와 실기 모두 다 봄 : 검정색펜과 수정펜만 가지고 작성해야함. (연필도 가능!!!!!!!! +지우개)
서버파일에 아무것도 없어야함_깃허브에 다 업로드 해두기
*/


proc ttest data=stat2.class H0=80 alpha=0.05 ;
	var math;
run;


proc univariate data=stat2.class mu0=80 alpha=0.05 cibasic;
	var math;
run;







proc univariate data=stat2.class mu0=80 alpha=0.05 cibasic;
	class gender;
	var math;
run;


/* class by 둘다 가능함 */
/* 둘로 나누면 전펴 표본수가 줄어드므로, 정규성 검정을 해야함 */
proc ttest data=stat2.class H0=80 alpha=0.05 ;
	class gender;
	var math;
run; 


proc sort data=stat2.class;
	by gender;
run;
proc ttest data=stat2.class H0=80 alpha=0.05 ;
	by gender;
	var math;
run; 

proc univariate data=stat2.class normal plot;
	class gender;
	var math;
run;

/* 여기서 남자의 결과를 보면, 양측검정일때 귀무가설 기각하는데(나누기 2를 하기 때문!! 뮤가 80보다 크다), 단측검정일때는 귀무가설을 기각하지 못함. */


/* 예시 시험문제 */
/* IQ=iq2-iq1 IQ의 평균이 0과 다르다고 할 수 있는가? */

data class_iq;
	set stat2.class;
	iq=iq2-iq1;
	keep iq1 iq2 iq;
run;


proc ttest data=class_iq h0=0 alpha=0.05;
	var iq;
run;


/* univariate의 디폴트는 MU0은 0이므로, 굳이 지정하지 않아도 됨!!*/
proc univariate data=class_iq;
	var iq;
run;

/* 통계전공자가의 수학점수는 80점과 다르다고할 수 있는가?
단 통계전공자는 15명이다.  */

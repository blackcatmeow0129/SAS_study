/* 5.1 */
data stat2.exam5_1;
input id weight;
cards;
1 10.21
2 10.53
3 9.99
4 11.11
5 10.47
6 10.48
7 10.35
8 10.63
9 11.07
10 10.61
11 10.33
12 10.01
13 11.2
14 10.41
15 10.33
16 10.12
17 10.78
18 10.91
19 10.37
20 9.58
;

proc univariate data=stat2.exam5_1 normal plot;
	var weight;
run;

proc means data=stat2.exam5_1 mean median std skewness kurtosis;
	var weight;
run;

proc summary data=stat2.exam5_1 mean P50 std skew kurt print;
	var weight;
run;


/* 5.2 */
data stat2.exam5_2;
input id year$ score;
cards;
1 L 88
2 L 68
3 L 77
4 L 75
5 L 84
6 L 90
7 L 95
8 L 73
9 L 69
10 L 80
11 L 79
12 L 82
13 L 95
14 L 62
15 H 82
16 H 86
17 H 88
18 H 92
19 H 77
20 H 72
21 H 96
22 H 75
23 H 68
24 H 96
25 H 85
26 H 86
27 H 76
28 H 89
29 H 83
;

/* 성적 자료에 대한 기술통계량 */
proc univariate data=stat2.exam5_2 normal plot;
	class year;
	var score;
run;

/* 히스토그램과 상자그림 */
proc gchart data=stat2.exam5_2;
	vbar score/ space=0 width=10;
run;

proc boxplot data=stat2.exam5_2;
	plot score*year/ boxstyle=schematic;
run;

/* 위의 자료가 정규분포를 한다고 할 수 있는지 설명하시오 */
proc univariate data=stat2.exam5_2 normal plot;
	class year;
	var score;
run;

/*
  
이를 판단하기 위해 S-W (Shapiro-wilk)를 이용해 정규성 검정을 해야합니다. 이는 다음과 같습니다.

H0(귀무가설) : 모집단의 분포는 정규분포이다
H1(대립가설) : 모집단의 분포는 정규분포가 아니다
alpha(유의수준) : 5%

이걸 판단하기 위해서는 univariate의 normal 옵션으로 확인할 수 있습니다. 

먼저 year이 H(2,3,4학년)인 경우, P는 0.7924, alpha는 0.05입니다.
유의확률이 유의수준보다 높으므로 귀무가설을 기각할 수 없습니다. 그러므로 모집단의 분포는 정규분포를 따릅니다. 
그리고 year이 L(1학년)인 경우, P는 0.0.9172, alpha는 0.05입니다. 
유의확률이 유의수준보다 높으므로 귀무가설을 기각할 수 없습니다. 그러므로 모집단의 분포는 정규분포를 따릅니다.

*/



/* Mean 이용 */
proc means data=stat2.exam5_2 mean std CV max min;
	class year;
	var score;
run;




/* 5.3 */

proc summary data=stat2.exam5_2 mean print;
	class year;
	var score;
output out=stat2.exam5_3 mean(score)=;
run;


/* 5.4 */

proc univariate data=stat2.exam5_2;
	class year;
	var score;
histogram score/normal(mu=est sigma=est);
run;


/* 5.5 */
/* univariate normal plot으로 출력하면 box plot이 함께 출력됩니다. */

Proc univariate data=stat2.exam5_1 normal plot;
	var weight;
run;


/* 5.6 */
proc gchart data=stat2.exam5_2;
	vbar score/ space=0 width=10;
run;


/* 5.7 */
/* 다음 univariate명령어를 통해 이상치를 점검할 수 있습니다. 다음 박스플롯으로 전체 상자그림을 출력할 수 있습니다. 
그리고 만약 이상치가 있다면 외부에 원이 생기며 이상치가 표시됩니다. 

그러나 지금 이 자료를 분석해 보았을 때는 이상치가 확인되지 않습니다. */

Proc univariate data=stat2.exam5_2 normal plot;
	var score;
run;



data recycle; 
infile '/home/u64470274/sasuser.v94/Datafile/rec.txt';
input id a1-a3 b1-b7 c1-c10 gender$ learning race;
run;

proc freq data=recycle;
tables a1-a3 b1-b7 c1-c10 gender learning race;
run;
proc print data=recycle;
run;


data recycle;
array q id a1-a3 b1-b7 c1-c10 gender$ learning race;
do over q;
 IF q=
/*  
<다음 문제는 꼭 낸다고 하심!>
: using freq!

다음값중 이상한 값이 포함된 변수와 id를 적으시오.
* 이상한값 : 목록에는 없는데 오타일 가능성이 높은 값. 
* 만약에 존재하지 않다면 '없음'이라고 적어야함. & 하나이상 존재하면 다 적기



<이걸 해결하는 방법.>

1. 이상한값을 포함하는 케이스를 삭제후 분석 
data r1;
set recycle;
if a2=8 then delete;
run;

2. 이상한 값을 결측값으로 바꾼뒤 분석
data r2;
set recycle;
id a2=8 then a2=.;
run;

*/

data r1;
set recycle;
if a2=8 then delete;
run;

data r2;
set recycle;
if a2=8 then a2=.;
run;


proc tabulate data=r2;
class gender race / order=freq;
table gender*F=6.1 race*F=6.1;
run;


/* 
class 옵션
missing 결측값이 존재하는 관측치도 포함시킴. 
*/
proc tabulate data=r2;
class a2;
table a2*F=6.1;
run;

proc tabulate data=r2;
class a2 / missing;
table a2*F=6.1;
run;

/*  
label문은 '출력결과'에 영향을 줍니다. (보이는 모습만 바꾸는거고 실제 안에 값은 바뀌지 않음. )

*/
data r2;
set r2;
label gender='성별' learning='최종학력' race='인종';
run;

/* 얘는 되고 */
proc tabulate data=r2;
class gender race / order=freq;
table gender*F=6.1 race*F=6.1;
run;

/* 얘는 안됨 */
proc tabulate data=r2;
class 성별 인종 / order=freq;
table 성별*F=6.1 인종*F=6.1;
run;


/*  
그냥 하는것과 printmiss를 넣는것 두개를 비교하는 거임.
printmiss가 있으면 결측값도 포함시켜서 나옴띠
시험에는 안나옴 ㅎ

*/
proc tabulate data=r2;
class gender race;
table gender*race*F=4.1;
table gender*race*F=4.1 / printmiss;
run;

/* 얘도 보여주는애 */
proc format;
value f_b 1='아주 귀찮다' 2='조금 귀찮다' 3='전혀 문제없다' 4='모르겠다';
value f_c 1='전적으로 동의' 2='다소 동의' 3='다소 반대' 4='전적으로 반대' 5='모르겠음';
value $f_gender 'F'='여자' 'M'='남자';
value f_learning 1='8학년' 2='고등학교 중퇴' 3='고등학교 졸업' 4='전문대학/직업학교' 5='대학교 중퇴' 6='대학교 졸업'
7='대학원 졸업' 8='응답거절';
value f_race 1='흑인' 2='백인' 3-<6='기타' 6='응답거절';
run;


proc tabulate data=r2;
format gender $f_gender. race f_race.;
class gender race / order=freq;
table gender*F=7.1 race*F=9.1;
run;

/* lable을 길게 넣어도 ㅇㅋ : 설명하기 위한거라 제약이 없음.  */
proc tabulate data=r2;
format gender $f_gender. b1 f_b.;
class gender b1;
table b1='음료캔과 플라스틱통 처리'*gender*F=6.1;
run;

/* 이거 이상함. */
proc tabulate data=r2;
format learning f_learning. c10 f_c10.;
class learning c10;
table learning, c10='환경단체에 자원봉사할 생각'*F=8.1 ALL='전체'*F=5.1 / misstext='없음';
run;

/* 다 못씀.....ㅠㅠ */
proc tabulate data=r2;
format gender $f_gender. b7 f_b.;
class gender b7;
table
b7='재활용품을 정리해서 집앞에 내놓는 일'*F=3.0, (gender ALL='전체')*('N'='응답자수'*F=5.0 'PCTN'='백분률')


/*  */



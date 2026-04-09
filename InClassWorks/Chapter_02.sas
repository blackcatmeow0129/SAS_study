data stat2.exam1;
* 여기에 파일 불러올거의 주소를 넣어야함 ;
input class id name$ 10. gender$ dept$ age reg$ 10.; * 문자$는 문자라는 의미, num.하면 길이를 늘릴수 있음;
cards;
1  1  김승현  M  통계  20 서울   
1  2  최경희  F  전산  20 광역시 
1  3  강희영  F  전산  20 서울   
1  4  이남석  M  전산  20 지방   
1  5  이주형  M  전산  21 서울   
1  6  한상철  M  통계  20 지방   
1  7  김호준  M  통계  20 광역시 
1  8  김선영  F  통계  22 서울   
1  9  정동준  M  통계  20 지방   
1 10  이수미  F  전산  20 광역시 
1 11  이정아  F  전산  21 지방   
1 12  한경기  M  통계  21 지방   
1 13  김숙희  F  통계  22 서울   
1 14  한미라  F  전산  20 광역시  
1 15  임철민  M  통계  25 광역시
;
proc print data=stat2.exam1;
run;


data stat2.exam2;
infile '/home/u64470274/sasuser.v94/data_file/a202.txt'; *데이터에 한한글이 있으면, txt파일을 UTF-8로 헤서 저장해야함;
input class id name$ 10. math eng iq1 iq2;
run;
proc print data = stat2.exam2;
run;


data stat2.exam4;
infile '/home/u64470274/sasuser.v94/data_file/a4.txt'; *공백이 없음 -> 범위를 지정해서 정해줘야함. ;
input class 1 id 2-3 name $ 4-12 math 13-14 eng 15-16 iq1 17-19 iq2 20-22; *data -> infile -> input의 순서를 지켜야함.;
run;
proc print data=stat2.exam4;
run;


proc import 
		out = stat2.exam3
		datafile ='/home/u64470274/sasuser.v94/data_file/a3.xlsx'
		dbms=xlsx
		replace;
		getnames=yes;
	run;
proc print data = stat2.exam2;
run;




/* 연습문제1 */
/* 새로운 데이터를 저렇게 저장하시오 */

data stat2.exam2_11;
input id gender$ mid final;
cards;

2002001 M 78 88
2002002 F 75 80
2002003 F 86 79
2002004 M 92 88
2002005 M 88 93
2002006 F 67 90
2002007 M 86 77
2002008 M 80 87
2002009 F 95 86
2002010 M 79 90
;
proc print data=stat2.exam2_11; run;


/* 연습문제2 */
 




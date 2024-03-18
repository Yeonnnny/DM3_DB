/*
[문제]
걸그룹과 팬클럽, 그리고 걸그룹 소속사를 관리하는 데이터베이스를 설계하려고 한다.

필요하다고 판단되는 모든 테이블과 컬럼을 ERD로 그리고, 코드 설계하시오.

아이돌:소속사 = many:1
아이돌:팬클럽 = 1:1

FK => 설계속성
PK => 식별자 

제약조건

*/

-- 1) 아이돌 그룹
/*
아이디
그룹명
인원
앨범수
데뷔날짜
장르
*/
drop table idol
create table idol
(
    group_id,
    group_name,
    member_num
);

--2) 멤버
/*
아이디
활동명
본명
생년월일
국적
성별
역할
최종학력 (초졸,중졸,고졸,대졸)
출신학교
종교
연습생 기간
mbti
*/
drop table members
create table members




-- 3) 팬클럽
/*
아이디
가입비
이름
홈페이지
회원수
소속사
색깔
*/
drop table fanclub
create table fanclub




-- 4) 소속사
/*
소속사이름
소속그룹
매출액
대표명
직원수 
회사소개
주소
상장여부
설립일
ghavpdlwl
*/
drop table entertainment
create table entertainment



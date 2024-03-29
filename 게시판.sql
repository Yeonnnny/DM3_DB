-- 2024/03/12
-- 회원 전용 게시판 테이블

-- 객체삭제 명령어
drop table reply;
drop table board;
drop table members;

drop SEQUENCE reply_seq;
drop SEQUENCE board_seq;
drop SEQUENCE members_seq;

-- 1) 회원 테이블
create table members(

);


-- 2) 게시판 테이블
create table board(
    board_num           number constraints board_num primary key,
    board_writer        varchar2(20) constraints board_writer not null,
    board_title         varchar2(20) default '제목없음',
    board_content       varchar2(4000),
    hit_count           number default 0,
    favorite_count      number default 0,
    create_date         date default sysdate,
    update_date         date
);

create SEQUENCE board_seq;

--board_title 문자열 길이를 200으로 변경함
alter table board modify board_title varchar2(200);

-- 첨부 파일에 대한 컬럼 추가
alter table board add originalFileName varchar2(200);
alter table board add savedFileName varchar2(200);

-- 첨부 파일에 대한 컬럼명 변경
ALTER TABLE board RENAME COLUMN originalFileName TO original_file_name;
ALTER TABLE board RENAME COLUMN savedFileName TO saved_file_name;

select * from board;



-- 3) 댓글 테이블
create table reply(

);













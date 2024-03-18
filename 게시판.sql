-- 2024/03/12
-- ȸ�� ���� �Խ��� ���̺�

-- ��ü���� ��ɾ�
drop table reply;
drop table board;
drop table members;

drop SEQUENCE reply_seq;
drop SEQUENCE board_seq;
drop SEQUENCE members_seq;

-- 1) ȸ�� ���̺�
create table members(

);


-- 2) �Խ��� ���̺�
create table board(
    board_num           number constraints board_num primary key,
    board_writer        varchar2(20) constraints board_writer not null,
    board_title         varchar2(20) default '�������',
    board_content       varchar2(4000),
    hit_count           number default 0,
    favorite_count      number default 0,
    create_date         date default sysdate,
    update_date         date
);

create SEQUENCE board_seq;

--board_title ���ڿ� ���̸� 200���� ������
alter table board modify board_title varchar2(200);

-- ÷�� ���Ͽ� ���� �÷� �߰�
alter table board add originalFileName varchar2(200);
alter table board add savedFileName varchar2(200);

-- ÷�� ���Ͽ� ���� �÷��� ����
ALTER TABLE board RENAME COLUMN originalFileName TO original_file_name;
ALTER TABLE board RENAME COLUMN savedFileName TO saved_file_name;

select * from board;



-- 3) ��� ���̺�
create table reply(

);













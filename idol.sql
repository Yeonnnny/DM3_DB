/*
[����]
�ɱ׷�� ��Ŭ��, �׸��� �ɱ׷� �Ҽӻ縦 �����ϴ� �����ͺ��̽��� �����Ϸ��� �Ѵ�.

�ʿ��ϴٰ� �ǴܵǴ� ��� ���̺�� �÷��� ERD�� �׸���, �ڵ� �����Ͻÿ�.

���̵�:�Ҽӻ� = many:1
���̵�:��Ŭ�� = 1:1

FK => ����Ӽ�
PK => �ĺ��� 

��������

*/

-- 1) ���̵� �׷�
/*
���̵�
�׷��
�ο�
�ٹ���
���߳�¥
�帣
*/
drop table idol
create table idol
(
    group_id,
    group_name,
    member_num
);

--2) ���
/*
���̵�
Ȱ����
����
�������
����
����
����
�����з� (����,����,����,����)
����б�
����
������ �Ⱓ
mbti
*/
drop table members
create table members




-- 3) ��Ŭ��
/*
���̵�
���Ժ�
�̸�
Ȩ������
ȸ����
�Ҽӻ�
����
*/
drop table fanclub
create table fanclub




-- 4) �Ҽӻ�
/*
�Ҽӻ��̸�
�Ҽӱ׷�
�����
��ǥ��
������ 
ȸ��Ұ�
�ּ�
���忩��
������
ghavpdlwl
*/
drop table entertainment
create table entertainment



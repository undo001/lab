use hr;
-- ---------------------------------------------------------------------------
-- 1
rollback, commit
-- ---------------------------------------------------------------------------

-- 2
join
-- ---------------------------------------------------------------------------

-- 3
1. NOT null
2. unique
3. PRIMARY key
4. FOREIGN key
5. default
6. check
-- ---------------------------------------------------------------------------

-- 4
select
	last_name as 성,
	salary as 급여
from employees
where department_id = 20 or department_id = 50;
-- ---------------------------------------------------------------------------

-- 5
select
	employee_id as 사번,
	last_name as 성,
	first_name as 이름,
	department_id as 부서명
from employees
where hire_date >= '2007/01/01' and hire_date < '2008/01/01'
order by employee_id desc;
-- ---------------------------------------------------------------------------

-- 6
select 
	job_id as 직업군,
	max(salary) as '최대 급여',
	min(salary) as '최소 급여',
	sum(salary) as '급여 합계',
	round(avg(salary)) as '급여 평균'
from employees
group by job_id
order by job_id;
-- ---------------------------------------------------------------------------

-- 7
select * from employees;

select * from departments;

select 
    d.department_id as 부서번호,
    d.department_name as 부서명,
    COUNT(e.employee_id) as 부서인원
from 
    departments d
join
    employees e 
ON 
    d.department_id = e.department_id
group by 
    d.department_id, d.department_name
having 
    count(e.employee_id) = 1;
-- ---------------------------------------------------------------------------
   
-- 8
-- 8-1) 테이블 생성 쿼리 (제약조건명 필요 없음)
drop table if exists tbl_member;
   
create table tbl_member(
	id 			varchar(50) primary key,
	pw 			varchar(50) not null,
	address 	varchar(50) unique,
	phone		varchar(50) not null,
	gender		char(1),
	create_date date default (current_date),
	constraint unq_tblmember_id unique(id),
	constraint chk_tblmember_gender check(gender in('M', 'F'))
);

-- 8-2) 테이블의 구조를 확인하는 쿼리 
desc tbl_member;

-- 8-3) 데이터 1개를 넣는 쿼리 (DEFAULT는 입력하지 않고 넣을 값들은 임의의 값으로)
-- 첫번째 코드 오류
-- insert into tbl_member(id, pw, address, phone, gender)
-- values('11', 'asd123123', '광주광역시', '010-2345-5678', 'a'); -- check 조건에 의해 M 또는 F만 들어감

insert into tbl_member (id, pw, address, phone, gender)
values ('user1', 'password2', '서울', '010-1234-5678', 'M');

insert into tbl_member (id, pw, address, phone, gender)
values ('user2', 'password1', '부산', '010-1234-5678', 'M');

-- 8-4)
select * from tbl_member;
-- ---------------------------------------------------------------------------

-- 9
-- 9-1) 테이블 생성 쿼리 (제약조건명 필요 없음) 
drop table if exists tbl_board;

create table tbl_board(
	BOARD_ID 	int auto_increment,
	WRITER 		varchar(50),
	TITLE 		varchar(50) not null,
	CONTENT		varchar(1000) not null,
	REGIST_DATE datetime default current_timestamp,
	UPDATE_DATE datetime default current_timestamp,
	constraint tbl_brdwr primary key(BOARD_ID),
	constraint tbl_brdwr foreign key(WRITER) references tbl_member(id) on delete cascade
);

-- 9-2) 테이블의 구조를 확인하는 쿼리
desc tbl_board;

-- 9-3)  데이터 1개를 넣는 쿼리 (자동증가, DEFAULT는 입력하지 않고 넣을 값들은 임의의 값으로)
insert into tbl_board (WRITER, TITLE, CONTENT)
values ('user1', '예시1', '가나다');

insert into tbl_board (WRITER, TITLE, CONTENT)
values ('user1', '예시2', '나다라');

insert into tbl_board (WRITER, TITLE, CONTENT)
values ('user2', '예시3', '다라마');

-- 9-4) 데이터가 잘 들어갔는지 확인하는 쿼리
select * from tbl_board;

-- 삭제 확인
select * from tbl_member;
select * from tbl_board;
DELETE FROM tbl_member WHERE id = 'user1';
-- ---------------------------------------------------------------------------

-- 10
select * from tbl_member;
select * from tbl_board;

-- 10-1) 회원 정보 수정/ - 8-3)에서 입력한 데이터의 폰번호를 3333-3333으로 수정하는 쿼리. 
update tbl_member
set phone = '3333-3333'
where id = 'user1';

-- 10-2) 게시판 내용 수정/ - 9-3)에서 입력한 데이터의 내용(CONTENT)을 데이터베이스!! 로 수정하는 쿼리 
update tbl_board
set CONTENT = '데이터베이스!!'
where BOARD_ID = 1; -- BOARD_ID는 입력된 데이터의 ID

-- 10-3) 게시판 글 삭제/ - 9-3)에서 입력한 데이터를 삭제하는 쿼리.
delete from tbl_board
where BOARD_ID = 1; -- 삭제할 글의 ID

-- 10-4) 회원 탈퇴/ - 8-3)에서 입력한 데이터를 삭제하는 쿼리 
delete from tbl_member
where id = 'user1'; -- 탈퇴할 회원의 ID
-- ---------------------------------------------------------------------------

 
   
   
   
   
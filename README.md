#### ASP.NET-MSSQL-JoinForm
#### MSSQL

#### 1. DB 생성
```sql

CREATE TABLE 회원관리(
	사번 varchar(5) NOT NULL DEFAULT REPLICATE('0',5 - LEN(NEXT VALUE FOR SEQ_HSH))+CONVERT(varchar(5),NEXT VALUE FOR SEQ_HSH),
	성명 varchar(10),
	주민번호 varchar(13),
	성별 char(1),
	이메일 varchar(100),
	전화번호 varchar(11),
	우편번호 varchar(6),
	주소 varchar(200),
	부서 varchar(20),
	직위 varchar(20),
	CONSTRAINT SET_PK PRIMARY KEY(사번)
)

```

#### 2. Blog 주소
<https://blog.naver.com/sori4739/221858481265>

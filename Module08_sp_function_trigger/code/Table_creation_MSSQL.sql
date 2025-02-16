DROP DATABASE IF EXISTS Module08
GO
CREATE DATABASE Module08 COLLATE Korean_Wansung_CI_AS;
GO
USE Module08;
GO

CREATE TABLE Users (
	UserNo		int,
    UserID		varchar(10)		UNIQUE,
    UserName	varchar(10),
    UserEmail	varchar(50)		UNIQUE,
    UserNickname	varchar(15),
    
    CONSTRAINT pk_Users PRIMARY KEY(UserNo)
)
GO

CREATE TABLE Board (
	BoardNo		int,
    BoardName	varchar(50),
    Description	varchar(4000),
    CreateDate	datetime	DEFAULT getdate(),
    
    CONSTRAINT pk_Board PRIMARY KEY(BoardNo)
)
GO

CREATE TABLE Article (
	ArticleNo	int,
    Title		varchar(300),
    Contents	text,
    BoardNo		int,
    WriterNo	int,
    WriteDate	datetime	default getdate(),
    UpdateDate	datetime,
    
    CONSTRAINT pk_ArticleNo PRIMARY KEY(ArticleNo),
    CONSTRAINT fk_article_board FOREIGN KEY(BoardNo) REFERENCES Board(BoardNo),
    CONSTRAINT fk_article_Writer FOREIGN KEY(WriterNo) REFERENCES Users(UserNo)
)
GO

INSERT INTO Users VALUES
	(1, 'killdong', '홍길동','killdong@gmail.com', '킬동'),
    (2, 'general', '이순신','general@hotmail.com', '장군님'),
    (3, 'jungkeun', '안중근', 'jungkeun@nhn.com', '조국독립')
GO
    
INSERT INTO Board (BoardNo, BoardName, Description) VALUES
	(1, '평양냉면', '평양냉면 게시판'),
    (2, '진주냉면', '진주냉면 게시판'),
    (3, '밀면', '밀면 게시판')
GO
    
INSERT INTO Article (ArticleNo, Title, Contents, BoardNo, WriterNo) VALUES 
	(1, '의정부 평양면옥 고양 스타필드점', '의정부 평양면옥, 장충동 평양면옥, 을밀대 그리고 우래옥. 오늘 점심을 먹은 의정부 평양면옥은 흔히들 "의정부 계열"이라고 불리는 의정부 평양면옥이다. 스타필드 고양점에 있는 분점인데, 예전에는 1층에 있었는데 3층으로 옮겼다.', 1, 1),
    (2, '봉피양 방이점', '평양냉면은 평양 대동강 근처에서 메밀 수제비 반죽을 국수로 뽑아서 찬 국물에 말아먹은 것이 시초라한다. 메밀은 글루텐 성분이 많지 않아 국수로 뽑기 까다로운 작물이라, 평양냉면이 보편화 된 것은 그리 오래지 않은 일이라 볼 수 있다고 한다.', 1, 2),
    (3, '진주냉면 산홍 금산본점', '진주냉면은 1800년대 후반, 진주목의 셰프가 독립하여 진주 옥봉동에서 냉면집을 개업한 것이 시초라고 알려져 있다. 진주냉면은 다른 냉면과 같이 고기로만 육수를 내지 않고 소고기 육수에 건어물(멸치, 바지락, 건홍합, 마른 명태 등)으로 육수를 내며, 뜨겁게 달군 쇠막대를 육수에 담궈 잡내를 순식간에 제거하는 것으로 알려져 있으나 실제 진주 냉면집에서 뜨거운 막대를 쓰는 방법은 사용하지 않는다고 한다.', 2, 1),
    (4, '박군자 진주냉면 예하리점', '넷짜 아들이 사천에서 식당을 운영중이고, 부산의 하기연 진주냉면은 첫째 딸이 운영중이며, 박군자 진주냉면은 첫째 며느리가 운영하는 곳이라고 한다. 현재는 프랜차이즈화 되어 전국 곳곳에서 진주냉면을 맛 볼 수 있다.', 2, 3),
    (5, '개금밀면', '밀면은 625때 부산으로 피난온 북한 사람들이 냉면을 먹고자 했으나 메밀을 구하기 힘들어 미군에게 원조받은 밀가루로 면을 민들어 육수에 말아먹은 음식으로 알려져있다. 그 과정에서 로컬라이제이션이 이루어, 경상도 음식답게 맵고 짠 맛이 많이 들어간 부산 토속음식이 되었다. 소고기 편육이 올라가는 냉면과는 달리 돼지고기 편육이 올라간다.', 3, 2)
GO
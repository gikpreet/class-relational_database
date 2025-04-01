= 답은 나중에 공개됩니다.

////
# 01. 영화 '퍼스트 맨'의 제작 연도, 영문 제목, 러닝 타임, 플롯을 출력하세요
SELECT ReleaseYear, Title, RunningTime, Plot FROM movie WHERE KoreanTitle = '퍼스트 맨';

# 02. 2003년에 개봉한 영화의 한글 제목과 영문 제목을 출력하세요
SELECT KoreanTitle, Title FROM movie WHERE ReleaseYear = '2003';

# 03. 영화 '글래디에이터'의 작곡가(Composer)의 한글 이름을 출력하세요
SELECT KoreanName 
FROM person NATURAL JOIN appear NATURAL JOIN movie NATURAL JOIN role
WHERE movie.KoreanTitle = '글래디에이터'
	AND role.RoleKorName = '작곡';
    
# 04. 영화 '매트릭스' 의 감독이 몇 명인지 출력하세요
SELECT COUNT(M.MovieID)
FROM appear AS S NATURAL JOIN movie AS M NATURAL JOIN role AS R
WHERE M.KoreanTitle = '매트릭스'
	AND R.RoleKorName = '감독';

# 05. 감독이 2명 이상인 영화의 정보를 다음 형식으로 출력하세요(하나의 컬럼)
# * 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(Title, '(', KoreanTitle, ') - ', ReleaseYear) AS result
FROM person NATURAL JOIN appear NATURAL JOIN movie NATURAL JOIN role
WHERE role.RoleKorName = '감독'
GROUP BY movie.Title, KoreanTitle, ReleaseYear
HAVING COUNT(Title) > 1;

# 06. '한스 짐머'가 참여한 영화 중 아카데미를 수상한 영화의 한글 제목을 출력하세요
SELECT KoreanTitle
FROM person NATURAL JOIN appear NATURAL JOIN movie NATURAL JOIN role NATURAL JOIN awardinvolve
WHERE
	person.KoreanName = '한스 짐머' AND
	awardinvolve.WinningID = 2;
    
# 07. 감독이 '제임스 카메론'이고 '아놀드 슈워제네거'가 출연한 영화를 다음 형식으로 출력하세요(하나의 컬럼). 개봉 연도를 기준으로 내림차순 정렬되어야 합니다.
# * 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(Title, '(', KoreanTitle, ') - ', ReleaseYear) AS result
FROM person NATURAL JOIN appear NATURAL JOIN movie NATURAL JOIN role
WHERE
	person.KoreanName = '제임스 카메론' AND role.RoleKorName = '감독'
INTERSECT
SELECT CONCAT(Title, '(', KoreanTitle, ') - ', ReleaseYear) AS result
FROM person NATURAL JOIN appear NATURAL JOIN movie NATURAL JOIN role
WHERE
	person.KoreanName = '아놀드 슈워제네거' AND role.RoleKorName = '배우';
    
# 08. 상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 한글 제목과 개봉 연도를 출력하세요. 개봉 연도를 기준으로 내림차순 정렬되어야 합니다.
SELECT KoreanTitle, ReleaseYear
FROM movie M NATURAL JOIN appear NATURAL JOIN person P NATURAL JOIN role R
WHERE R.roleName = 'actor' AND M.ReleaseYear >= 100 AND P.KoreanName = '레오나르도 디카프리오'
ORDER BY M.ReleaseYear;

# 09. 청소년 관람불가 등급의 영화 중 가장 많은 수익을 얻은 영화의 한글 제목을 출력하세요.
SELECT KoreanTitle
FROM movie M NATURAL JOIN gradeinkorea G
WHERE G.GradeInKoreaName = '청소년 관람불가'
ORDER BY BoxOfficeWWGross DESC LIMIT 1;

# 10. 1999년 이전에 제작된 영화의 수익 평균을 고르시오. 출력 형식은 통화 형식이어야 합니다.
SELECT CONCAT('$', FORMAT(AVG(BoxOfficeWWGross), 'C', 'en-us')) AS 'Average revenue'
FROM movie 
WHERE ReleaseYear <= 1999;

# 11. 가장 많은 제작비가 투입된 영화를 다음 형식으로 출력하세요.
# * 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(Title, '(', KoreanTitle, ') - ', ReleaseYear)
FROM movie
WHERE Budget = (SELECT MAX(Budget) FROM movie);

# 12. 제작한 영화의 제작비 총합이 가장 높은 감독을 다음 형식으로 출력하세요.
# * 한글 이름(영문 이름)
SELECT CONCAT(P.KoreanName, '(', P.Name, ')') AS result
FROM person AS P INNER JOIN appear AS A ON P.PersonID = A.PersonID 
	INNER JOIN movie AS M ON A.MovieID = M.MovieID
	INNER JOIN role AS R ON A.RoleID = R.RoleID
WHERE R.RoleKorName = '감독'
GROUP BY P.KoreanName, P.Name
ORDER BY SUM(M.Budget) DESC LIMIT 1;

# 13. 출연한 영화의 모든 수익을 합하여, 총 수입이 가장 많은 배우의 한글 이름과 출생 연도를 출력하세요.(두 개의 컬럼)
SELECT KoreanName, Year(BirthDate)
FROM movie AS M NATURAL JOIN appear AS A NATURAL JOIN person AS P NATURAL JOIN role AS R
WHERE R.Rolename in ('Actor', 'Actress')
GROUP BY P.KoreanName, Year(P.BirthDate)
ORDER BY SUM(M.BoxOfficeWWGross) DESC LIMIT 1;

# 14. 제작비가 가장 적게 투입된 영화의 한글 제목과 수익을 출력하세요. 제작비가 0인 영화는 제외하며, 출력 형식은 통화 형식이어야 합니다.
SELECT KoreanTitle, CONCAT('$', FORMAT(BoxOfficeWWGross, 'C', 'en-us')) AS 'BoxOfficeWWGross'
FROM movie
WHERE Budget = (SELECT MIN(Budget) FROM movie WHERE Budget <> 0);

# 15. 제작비가 5000만 달러 이하인 영화의 한글 제목과 미국내 평균 수익을 출력하세요. 출력 형식은 통화 형식이어야 합니다.
SELECT CONCAT('$', FORMAT(AVG(BoxOfficeUSGross), 'C', 'en-us')) AS 'Average US Gross'
FROM movie
WHERE Budget >= 50000000;

# 16. 액션 장르 영화의 평균 수익을 출력하세요. 출력 형식은 통화 형식이어야 합니다.
SELECT CONCAT('$', FORMAT(AVG(BoxOfficeUSGross), 'C', 'en-us')) AS 'Average revenue of Action movies'
FROM movie NATURAL JOIN moviegenre NATURAL JOIN genre
WHERE GenreKorName = '액션';

# 17. 장르가 드라마, 전쟁인 영화의 한글 제목을 아래 형식으로 출력하세요. 개봉 연도를 기준으로 내림차순 정렬되어야 합니다.
# * 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(KoreanTitle, '(', title, ') - ', ReleaseYear)
FROM
(SELECT Title, KoreanTitle, ReleaseYear
FROM movie NATURAL JOIN moviegenre NATURAL JOIN genre
WHERE genre.GenreKorName = '전쟁'
INTERSECT
SELECT Title, KoreanTitle, ReleaseYear
FROM movie NATURAL JOIN moviegenre NATURAL JOIN genre
WHERE genre.GenreKorName = '드라마'
EXCEPT
SELECT Title, KoreanTitle, ReleaseYear
FROM movie NATURAL JOIN moviegenre NATURAL JOIN genre
WHERE genre.GenreID IN (SELECT GenreID FROM genre WHERE GenreKorName NOT IN ('드라마', '전쟁'))) AS result
ORDER BY ReleaseYear desc;

# 18. 톰 행크스가 출연한 영화 중 상영 시간이 가장 긴 영화의 제목, 한글제목, 개봉연도를 출력하세요.(세 개의 컬럼)
SELECT title, Koreantitle, releaseYear
FROM movie NATURAL JOIN appear NATURAL JOIN person NATURAL JOIN role
WHERE
	person.KoreanName = '톰 행크스'
    AND
    role.RoleKorName = '배우'
ORDER BY RunningTime DESC LIMIT 1;

# 19. 아카데미 남우주연상을 가장 많이 수상한 배우의 한글 이름과 영문 이름을 출력하세요.(두 개의 컬럼))
SELECT KoreanName, Name
FROM
(SELECT KoreanName, Name, COUNT(Name) AS WinningCount
FROM person AS P NATURAL JOIN appear AS A NATURAL JOIN awardinvolve AS I NATURAL JOIN sector AS S
WHERE WinningID = 2 AND SectorKorName = '남우주연상'
GROUP BY KoreanName, Name) AS result
WHERE WinningCount = (SELECT MAX(WinningCount) FROM (SELECT KoreanName, Name, COUNT(Name) AS WinningCount
FROM person AS P NATURAL JOIN appear AS A NATURAL JOIN awardinvolve AS I NATURAL JOIN sector AS S
WHERE WinningID = 2 AND SectorKorName = '남우주연상'
GROUP BY KoreanName, Name) AS result);

# 20. 아카데미상을 가장 많이 수상한 배우의 한글 이름과 영문 이름을 출력하세요.('수상자 없음'이 이름인 영화인은 제외합니다)
SELECT KoreanName, Name
FROM
(SELECT KoreanName, Name, COUNT(Name) AS WinningCount
FROM person AS P INNER JOIN appear AS A ON P.PersonID = A.PersonID AND KoreanName <> '수상자 없음'
	INNER JOIN awardinvolve AS I ON A.AppearID = I.AppearID AND WinningID = 2
	INNER JOIN role AS R ON A.RoleID = R.RoleID AND R.RoleKorName = '배우'
GROUP BY KoreanName, Name) AS result
WHERE WinningCount = (SELECT MAX(WinningCount) FROM (SELECT KoreanName, Name, COUNT(Name) AS WinningCount
FROM person AS P INNER JOIN appear AS A ON P.PersonID = A.PersonID AND KoreanName <> '수상자 없음'
	INNER JOIN awardinvolve AS I ON A.AppearID = I.AppearID AND WinningID = 2
	INNER JOIN role AS R ON A.RoleID = R.RoleID AND R.RoleKorName = '배우'
GROUP BY KoreanName, Name) AS result);

# 21. 아카데미 남우주연상을 2번 이상 수상한 배우의 한글 이름과 영문 이름을 출력하세요.
SELECT KoreanName, Name
FROM person AS P NATURAL JOIN appear AS A NATURAL JOIN awardinvolve AS I NATURAL JOIN sector AS S
WHERE
	WinningID = 2 AND KoreanName <> '수상자 없음' AND S.SectorKorName = '남우주연상'
GROUP BY
	KoreanName, Name
HAVING 
	COUNT(KoreanName) >= 2;
    
# 22. 아카데미상을 가장 많이 수상한 사람의 한글 이름과 영문 이름을 출력하세요. (수상자에서 'John Doe'는 제외합니다)
SELECT KoreanName, Name
FROM (SELECT KoreanName, Name, COUNT(Name) AS WinningCount
FROM person NATURAL JOIN appear NATURAL JOIN awardinvolve 
WHERE WinningID = 2 AND NAME <> 'John Doe'
GROUP BY KoreanName, Name) AS result
WHERE WinningCount = 
(SELECT MAX(WinningCount) FROM (SELECT KoreanName, Name, COUNT(Name) AS WinningCount
FROM person NATURAL JOIN appear NATURAL JOIN awardinvolve 
WHERE WinningID = 2 AND NAME <> 'John Doe'
GROUP BY KoreanName, Name) AS result);
	
# 23. 아카데미상에 가장 많이 노미네이트 된 영화의 한글 제목, 영문 제목, 개봉 연도를 출력하세요. 개봉 연도를 기준으로 내림차순 정렬되어야 합니다.(세 개의 컬럼)
SELECT KoreanTitle, Title, ReleaseYear
FROM 
	(SELECT KoreanTitle, Title, ReleaseYear, COUNT(DISTINCT CONCAT(S.SectorID, IFNULL(I.Remark, ''))) AS NominateCount
	FROM movie AS M INNER JOIN appear AS A ON M.MovieID = A.MovieID
		INNER JOIN awardinvolve AS I ON A.AppearID = I.AppearID
		INNER JOIN sector AS S ON I.SectorID = S.SectorID
	GROUP BY KoreanTitle, Title, ReleaseYear) AS result
WHERE NominateCount = (
SELECT MAX(NominateCount) FROM (SELECT KoreanTitle, Title, ReleaseYear, COUNT(DISTINCT S.SectorID) AS NominateCount
FROM movie AS M INNER JOIN appear AS A ON M.MovieID = A.MovieID
		INNER JOIN awardinvolve AS I ON A.AppearID = I.AppearID
		INNER JOIN sector AS S ON I.SectorID = S.SectorID
GROUP BY KoreanTitle, Title, ReleaseYear) AS result);

# 24. 가장 많은 영화에 출연한 여배우의 한글 이름과 영문 이름을 출력하세요.
SELECT KoreanName, Name
FROM person AS P NATURAL JOIN appear AS A NATURAL JOIN role AS R
WHERE 
	R.RoleName = 'Actress'
GROUP BY KoreanName, Name 
ORDER BY COUNT(DISTINCT A.MovieID) DESC LIMIT 1;

# 25. 아카데미상을 가장 많이 수상한 영화를 아래 형식으로 출력하세요.
# * 한글영화제목(영문 영화제목) - 개봉연도
SELECT KoreanTitle, Title, ReleaseYear
FROM 
	(SELECT KoreanTitle, Title, ReleaseYear, COUNT(DISTINCT CONCAT(S.SectorID, I.Remark)) AS NominateCount
	FROM Movie AS M INNER JOIN Appear AS A ON M.MovieID = A.MovieID
		INNER JOIN AwardInvolve AS I ON A.AppearID = I.AppearID
		INNER JOIN Sector AS S ON I.SectorID = S.SectorID
	WHERE WinningID = 2
	GROUP BY KoreanTitle, Title, ReleaseYear) AS result
WHERE NominateCount = (
SELECT MAX(NominateCount) FROM (SELECT KoreanTitle, Title, ReleaseYear, COUNT(DISTINCT S.SectorID) AS NominateCount
FROM Movie AS M INNER JOIN Appear AS A ON M.MovieID = A.MovieID
		INNER JOIN AwardInvolve AS I ON A.AppearID = I.AppearID
		INNER JOIN Sector AS S ON I.SectorID = S.SectorID
WHERE WinningID = 2
GROUP BY KoreanTitle, Title, ReleaseYear) AS result);


# 26. 수익이 가장 높은 영화 TOP 10을 아래 형식으로 출력하세요. 수익으로 내림차순 정렬되어야 합니다.
# * 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(KoreanTitle, '(', Title, ') -', ReleaseYear)
FROM movie
ORDER BY BoxOfficeWWGross DESC LIMIT 10;

# 27. 수익이 10억불 이상인 영화중 제작비가 1억불 이하인 영화를 아래 형식으로 출력하세요. 제작비로 오름차순 정렬 되어야 합니다.
# * 한글영화제목(영문 영화제목) - 개봉연도
SELECT CONCAT(KoreanTitle, '(', Title, ') -', ReleaseYear)
FROM movie
WHERE BoxOfficeWWGross >= 1000000000
EXCEPT
SELECT CONCAT(KoreanTitle, '(', Title, ') -', ReleaseYear)
FROM movie
WHERE Budget <= 100000000;

# 28. 전쟁 영화를 가장 많이 감독한 사람의 한글 이름과 영문 이름을 출력하세요. (두 개의 컬럼)
SELECT KoreanName, Name, COUNT(name)
FROM person NATURAL JOIN appear NATURAL JOIN movie NATURAL JOIN role NATURAL JOIN moviegenre
WHERE
	role.RoleKorName = '감독'
    AND
    genreID = (SELECT GenreID FROM genre WHERE GenreKorName = '전쟁')
GROUP BY KoreanName, Name
ORDER BY COUNT(Name) DESC LIMIT 1;
    
# 29. 드라마에 가장 많이 출연한 사람의 한글 이름과 영문 이름을 출력하세요. (두 개의 컬럼)
SELECT KoreanName, Name, COUNT(KoreanName)
FROM person NATURAL JOIN appear NATURAL JOIN movie NATURAL JOIN moviegenre NATURAL JOIN genre NATURAL JOIN role
WHERE genre.GenreKorName = '드라마' AND role.RoleKorName = '배우'
GROUP BY KoreanName, Name
ORDER BY COUNT(KoreanName) DESC LIMIT 1;

# 30. 드라마 장르에 출연했지만 호러 영화에 한번도 출연하지 않은 남배우의 한글 이름과 영문 이름을 출력하세요.(두 개의 컬럼)
SELECT DISTINCT KoreanName, Name
FROM person AS P NATURAL JOIN appear AS A
		NATURAL JOIN movie AS M
		NATURAL JOIN role AS R
		NATURAL JOIN moviegenre AS MG
		NATURAL JOIN genre AS G
WHERE G.GenreKorName = '드라마' AND R.RoleKorName = '배우'
INTERSECT
SELECT DISTINCT KoreanName, Name
FROM person AS P NATURAL JOIN appear AS A
		NATURAL JOIN movie AS M
		NATURAL JOIN role AS R
		NATURAL JOIN moviegenre AS MG
		NATURAL JOIN genre AS G
WHERE G.GenreKorName NOT IN ('호러') AND R.RoleKorName = '배우';

# 31. 아카데미 영화제가 가장 많이 열린 장소는 어디인가요?
SELECT Location
FROM awardyear
GROUP BY Location
ORDER BY COUNT(Location) DESC LIMIT 1;

# 32. 첫 번째 아카데미 영화제가 열린지 올해 기준으로 몇년이 지났나요?
SELECT YEAR(Now()) - Year FROM awardyear ORDER BY Year ASC LIMIT 1;

# 33. SF 장르의 영화 중 아카데미 영화제 후보에 가장 많이 오른 영화의 한글 제목을 구하세요.
SELECT KoreanTitle, Title, ReleaseYear
FROM 
	(SELECT KoreanTitle, Title, ReleaseYear, COUNT(DISTINCT CONCAT(S.SectorID, IFNULL(I.Remark, ''))) AS NominateCount
	FROM movie AS M INNER JOIN appear AS A ON M.MovieID = A.MovieID
		INNER JOIN awardinvolve AS I ON A.AppearID = I.AppearID
		INNER JOIN sector AS S ON I.SectorID = S.SectorID
		INNER JOIN moviegenre AS MG ON M.MovieID = MG.MovieID
		INNER JOIN genre AS G ON MG.GenreID = G.GenreID
	WHERE G.GenreKorName = '공상과학'
	GROUP BY KoreanTitle, Title, ReleaseYear) AS result
WHERE NominateCount = (
SELECT MAX(NominateCount) FROM (SELECT KoreanTitle, Title, ReleaseYear, COUNT(DISTINCT S.SectorID) AS NominateCount
FROM movie AS M INNER JOIN appear AS A ON M.MovieID = A.MovieID
	INNER JOIN awardinvolve AS I ON A.AppearID = I.AppearID
	INNER JOIN sector AS S ON I.SectorID = S.SectorID
	INNER JOIN moviegenre AS MG ON M.MovieID = MG.MovieID
	INNER JOIN genre AS G ON MG.GenreID = G.GenreID
WHERE G.GenreKorName = '공상과학'
GROUP BY KoreanTitle, Title, ReleaseYear) AS result);

# 34. 드라마 장르의 영화의 아카데미 영화제 작품상 수상 비율을 구하세요.
SELECT @TotalCount := COUNT(DISTINCT Title)
FROM movie NATURAL JOIN appear
	NATURAL JOIN awardinvolve
	NATURAL JOIN moviegenre
	NATURAL JOIN genre
	NATURAL JOIN sector
WHERE 
	WinningID = 2 AND sector.SectorKorName = '작품상';
SELECT @WinningCount := COUNT(DISTINCT Title)
FROM movie NATURAL JOIN appear
	NATURAL JOIN awardinvolve
	NATURAL JOIN moviegenre
	NATURAL JOIN genre
	NATURAL JOIN sector
WHERE 
	WinningID = 2 AND sector.SectorKorName = '작품상' AND genre.GenreKorName = '드라마';
SELECT CONCAT(@WinningCount / @TotalCount * 100, '%') AS result;

# 35. '휴 잭맨'이 출연한 영화의 제작비 대비 수익율을 출력하세요.
SELECT @Budget := SUM(Budget)
FROM person AS P NATURAL JOIN appear AS A NATURAL JOIN movie AS M
WHERE P.KoreanName = '휴 잭맨';
SELECT @Revenue := SUM(BoxOfficeWWGross)
FROM person AS P NATURAL JOIN appear AS A NATURAL JOIN movie AS M
WHERE P.KoreanName = '휴 잭맨';
SELECT CONCAT(@Revenue / @Budget * 100, '%');

////
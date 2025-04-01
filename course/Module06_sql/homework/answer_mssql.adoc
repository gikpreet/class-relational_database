= 답은 나중에 공개됩니다.

////
# 1. 영화 '퍼스트 맨'의 제작 연도, 영문 제목, 러닝 타임, 플롯을 출력하세요.0
SELECT ReleaseYear, Title, RunningTime, Plot
FROM Movie
WHERE Movie.KoreanTitle = '퍼스트 맨';

# 2. 2003년에 개봉한 영화의 한글 제목과 영문 제목을 출력하세요
SELECT KoreanTitle, Title
FROM movie
WHERE ReleaseYear = 2003;

# 3. 영화 '글래디에이터'의 작곡가를 고르세요
SELECT Person.*, Role.*
FROM Person INNER JOIN Appear ON Person.PersonId = Appear.PersonID
	INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
    INNER JOIN Role ON Role.RoleID = Appear.RoleId
WHERE
	Movie.KoreanTitle = '글래디에이터'
    AND
    Role.RoleName = 'Composer';

# 4. 영화 '매트릭스'의 감독이 몇명인지 출력하세요
SELECT COUNT(*)
FROM Movie AS M INNER JOIN Appear AS A ON M.MovieID = A.MovieID
	INNER JOIN Role AS R ON A.RoleID = R.RoleID
WHERE 
	M.KoreanTitle = '매트릭스'
    AND
    R.RoleName = 'Director';

# 5. 감독이 2명 이상인 영화를 출력하세요
SELECT M.MovieId, M.Title, R.RoleName, COUNT(*)
FROM 
	Person AS P INNER JOIN Appear AS A ON P.PersonID = A.PersonID
	INNER JOIN Movie AS M ON M.MovieID = A.MovieID
	INNER JOIN Role AS R ON A.RoleID = R.RoleID
WHERE
	R.RoleName = 'Director'
GROUP BY M.MovieID, R.RoleName, M.Title
HAVING COUNT(R.RoleName) >= 2;

# 6. '한스 짐머'가 참여한 영화 중 아카데미를 수상한 영화를 출력하세요
SELECT Movie.Title, Movie.KoreanTitle, ReleaseYear
FROM 
	Person INNER JOIN Appear ON Person.PersonID = Appear.PersonID
    INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
    INNER JOIN AwardInvolve ON AwardInvolve.AppearID = Appear.AppearID
WHERE
	Person.KoreanName = '한스 짐머'
	AND
	AwardInvolve.WinningID = 2;
    

# 7. 감독이 '제임스 카메론'이고 '아놀드 슈워제네거'가 출연한 영화를 출력하세요
SELECT Director.Title, Director.KoreanTitle, Director.ReleaseYear
FROM
	(SELECT Movie.*
	FROM 
		Movie INNER JOIN Appear ON Movie.MovieID = Appear.MovieID
		INNER JOIN Person ON Person.PersonID = Appear.PersonID
		INNER JOIN Role ON Role.RoleID = Appear.RoleID
	WHERE 
		Role.RoleName = 'Director'
		AND 
		Person.KoreanName = '제임스 카메론') AS Director
	INNER JOIN 
	(SELECT Movie.*
	FROM 
		Movie INNER JOIN Appear ON Movie.MovieID = Appear.MovieID
		INNER JOIN Person ON Person.PersonID = Appear.PersonID
		INNER JOIN Role ON Role.RoleID = Appear.RoleID
	WHERE 
		Role.RoleName = 'Actor'
		AND 
		Person.KoreanName = '아놀드 슈워제네거') AS Actor
	ON Director.MovieID = Actor.MovieID;

# 8. 상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 영화를 고르시오
SELECT M.Title, M.KoreanTitle, M.ReleaseYear
FROM 
	Movie AS M INNER JOIN Appear AS A ON M.MovieID = A.MovieID
	INNER JOIN Person AS P ON P.PersonID = A.PersonID
	INNER JOIN Role AS R ON R.RoleID = A.RoleID
WHERE
	RunningTime >= 100
	AND
	KoreanName = '레오나르도 디카프리오'
	AND
	R.RoleName = 'Actor';
    
# 9. 미성년자 관람불가 등급의 영화 중 가장 많은 수익을 얻은 영화를 고르시오
SELECT Title, KoreanTitle, ReleaseYear
FROM
	Movie
WHERE
	BoxOfficeWWGross = (SELECT MAX(BoxOfficeWWGross) 
							FROM Movie AS M INNER JOIN GradeInKorea AS GK 
							ON GK.GradeInKoreaID = M.GradeInKoreaID
							WHERE
							GK.GradeInKoreaName = '청소년 관람불가');

# 10. 1999년 이전에 제작된 영화의 수익 평균을 고르시오
SELECT AVG(BoxOfficeWWGross)
FROM Movie
WHERE
	ReleaseYear < '1999';
    
# 11. 가장 많은 제작비가 투입된 영화를 고르시오.
SELECT Title, KoreanTitle, ReleaseYear, Budget
FROM Movie
ORDER BY Budget DESC
Limit 1;

# 12. 제작한 영화의 제작비 총합이 가장 높은 감독은 누구입니까?
SELECT Person.KoreanName, SUM(Movie.Budget)
FROM Person
	INNER JOIN Appear ON Appear.PersonID = Person.PersonID
    INNER JOIN Movie ON Movie.MovieId = Appear.MovieID
WHERE Appear.RoleId = 2
GROUP BY Person.KoreanName
ORDER BY SUM(Movie.Budget) DESC
LIMIT 1;

# 13. 총 영화 수입이 가장 많은 배우를 출력하세요.
SELECT Person.KoreanName, SUM(Movie.Budget)
FROM Person
	INNER JOIN Appear ON Appear.PersonID = Person.PersonID
    INNER JOIN Movie ON Movie.MovieId = Appear.MovieID
WHERE Appear.RoleId IN (6, 7)
GROUP BY Person.KoreanName
ORDER BY SUM(Movie.Budget) DESC
LIMIT 1;

# 14. 제작비가 가장 적게 투입된 영화의 수익을 고르세요. (제작비가 0인 영화는 제외합니다)
SELECT Title, BoxOfficeWWGross, BoxOfficeUSGross, Budget
FROM Movie
WHERE 
	Budget = (SELECT MIN(Budget) FROM Movie WHERE Budget <> 0);

# 15. 제작비가 5000만 달러 이하인 영화의 미국내 평균 수익을 고르세요
SELECT AVG(BoxOfficeWWGross), AVG(BoxOfficeUSGross)
FROM Movie
WHERE Budget <= 50000000;

# 16 액션 장르 영화의 평균 수익을 고르세요
SELECT AVG(BoxOfficeWWGross), AVG(BoxOfficeUSGross)
FROM Movie INNER JOIN MovieGenre ON Movie.MovieID = MovieGenre.MovieID
	INNER JOIN Genre ON MovieGenre.GenreID = Genre.GenreID
WHERE Genre.GenreName = 'Action';

# 17. 드라마, 전쟁 장르의 영화를 고르세요.
SELECT DISTINCT Title, KoreanTitle
FROM Movie INNER JOIN MovieGenre ON Movie.MovieID = MovieGenre.MovieID
	INNER JOIN Genre ON MovieGenre.GenreID = Genre.GenreID
WHERE
	Genre.GenreKorName IN ('드라마', '전쟁');
    
# 18. 톰 행크스가 출연한 영화 중 상영 시간이 가장 긴 영화를 고르세요
SELECT Movie.Title, Movie.KoreanTitle, Movie.RunningTime
FROM Movie
	INNER JOIN Appear ON Appear.MovieID = Movie.MovieID
    INNER JOIN Person ON Person.PersonID = Appear.PersonID
WHERE Person.KoreanName = '톰 행크스'
ORDER BY Movie.RunningTime DESC
LIMIT 1;

# 19. 아카데미 남우주연상을 가장 많이 수상한 배우를 고르시오
SELECT KoreanName, COUNT(*) AS Count
FROM
	Person INNER JOIN Appear ON Person.PersonID = Appear.PersonID
    INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
    INNER JOIN AwardInvolve ON AwardInvolve.AppearID = Appear.AppearID
	INNER JOIN Sector ON Sector.SectorID = Awardinvolve.SectorID
WHERE
	AwardInvolve.WinningID = 2
	AND
	Sector.SectorKorName = '남우주연상'
GROUP BY KoreanName
ORDER BY Count DESC
Limit 1;

# 20. 아카데미상을 가장 많이 수상한 영화인을 고르시오
SELECT KoreanName, COUNT(*) AS Count
FROM
	Person INNER JOIN Appear ON Person.PersonID = Appear.PersonID
    INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
    INNER JOIN AwardInvolve ON AwardInvolve.AppearID = Appear.AppearID
	INNER JOIN Sector ON Sector.SectorID = Awardinvolve.SectorID
WHERE
	AwardInvolve.WinningID = 2
    AND
    KoreanName <> '수상자 없음'
GROUP BY KoreanName
ORDER BY Count DESC
Limit 1;

# 21 아카데미 남우주연상을 2번 이상 수상한 배우를 고르시오
SELECT KoreanName, COUNT(*) AS Count
FROM
	Person INNER JOIN Appear ON Person.PersonID = Appear.PersonID
    INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
    INNER JOIN AwardInvolve ON AwardInvolve.AppearID = Appear.AppearID
	INNER JOIN Sector ON Sector.SectorID = Awardinvolve.SectorID
WHERE
	AwardInvolve.WinningID = 2
	AND
	Sector.SectorKorName = '남우주연상'
GROUP BY KoreanName, Person.PersonID
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;

# 23. 아카데미상을 가장 많이 수상한 사람을 고르세요.
SELECT KoreanName, COUNT(*) AS Count
FROM
	Person INNER JOIN Appear ON Person.PersonID = Appear.PersonID
    INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
    INNER JOIN AwardInvolve ON AwardInvolve.AppearID = Appear.AppearID
	INNER JOIN Sector ON Sector.SectorID = Awardinvolve.SectorID
WHERE
	AwardInvolve.WinningID = 2
    AND
    KoreanName <> '수상자 없음'
GROUP BY KoreanName
ORDER BY Count DESC
Limit 1;

# 24. 아카데미상에 가장 많이 노미네이트 된 영화를 고르세요.

# 25. 가장 많은 영화에 출연한 여배우를 고르세요.
SELECT Person.Name, COUNT(*) AS count
FROM Person
	INNER JOIN Appear ON Appear.PersonID = Person.PersonID
    INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
WHERE Appear.RoleID = 7
GROUP BY Person.Name
ORDER BY count DESC
LIMIT 1;

# 26. 수익이 가장 높은 영화 TOP 10을 출력하세요. 
SELECT Title, BoxOfficeWWGross
FROM Movie
ORDER BY BoxOfficeWWGross DESC
LIMIT 10;

# 27. 수익이 10억불 이상인 영화중 제작비가 1억불 이하인 영화를 고르시오.
SELECT Title, BoxOfficeWWGross, Budget
FROM Movie
WHERE BoxOfficeWWGross > 1000000000 AND Budget < 100000000;

# 28. 전쟁 영화를 가장 많이 감독한 사람을 고르세요.
SELECT Person.Name, COUNT(*) as count
FROM Person
	INNER JOIN Appear ON Appear.PersonID = Person.PersonID
    INNER JOIN Movie ON Movie.MovieID = Appear.MovieID
    INNER JOIN MovieGenre ON MovieGenre.MovieID = Movie.MovieID
WHERE Appear.RoleID = 2 AND MovieGenre.GenreID = 19
GROUP BY Person.Name
ORDER BY count DESC
LIMIT 1;

# 29. 드라마에 가장 많이 출연한 사람을 고르세요.
SELECT Person.Name, COUNT(*) AS count
FROM Person
	INNER JOIN Appear ON Appear.PersonID = Person.PersonID
    INNER JOIN MovieGenre ON MovieGenre.MovieID = Appear.MovieID
WHERE MovieGenre.GenreID = 1 AND Appear.RoleID = 6 OR MovieGenre.GenreID = 1 AND Appear.RoleID = 7
GROUP BY Person.Name
HAVING count
ORDER BY count DESC
LIMIT 1;

# 30. 드라마 장르에 출연했지만 호러 영화에 한번도 출연하지 않은 사람을 고르세요.
SELECT DISTINCT(Person.Name)
FROM Person
	INNER JOIN Appear ON Appear.PersonID = Person.PersonID
    INNER JOIN MovieGenre ON MovieGenre.MovieID = Appear.MovieID
WHERE NOT MovieGenre.GenreID = 22 AND MovieGenre.GenreID = 1;

# 31. 아카데미 영화제가 가장 많이 열린 장소는 어디인가요?
SELECT Location, COUNT(*) AS count
FROM AwardYear
GROUP BY Location
HAVING count
ORDER BY count DESC
LIMIT 1;

# 33. 첫 번째 아카데미 영화제가 열린지 올해 기준으로 몇년이 지났나요?
SELECT TIMESTAMPDIFF(YEAR, AwardYear.Date, CURDATE()) AS result
FROM AwardYear
ORDER BY result DESC
LIMIT 1;
////
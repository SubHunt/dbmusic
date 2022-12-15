--TRUNCATE TABLE genres RESTART IDENTITY CASCADE;
-- Заполняем таблицу жанры
INSERT INTO 
	genres (name) 
VALUES 
	('pop'),
	('rock'),
	('country'),
	('jazz'),
	('blues'),
	('rap');
	
--TRUNCATE TABLE singers RESTART IDENTITY CASCADE;
-- Заполняем таблицу исполнители
INSERT INTO 
	singers (name)
VALUES 
	('Michael Jackson'), 
	('Lady Gaga'),
	('Freddie Mercury'),
	('Mick Jagger'),
	('Jon Bon Jovi'),
	('Taylor Swift'),
	('Kenny Rogers'),
	('Robert Davi'),
	('Hozier'),
	('Eminem');
	
-- Заполняем таблицу связей жанры/исполнители
INSERT INTO 
	genressingers (singer_id, genre_id)
VALUES 
	(1,1),
	(2,1),
	(3,2),
	(4,2),
	(5,2),
	(6,3),
	(7,3),
	(8,4),
	(9,5),
	(10,6),
	(10,2);

-- Заполняем таблицу альбомы
INSERT INTO 
	albums (name, year)
VALUES
	('Dangerous',1991),
	('Born This Way',2001),
	('Never Boring',2019),
	('Goddess in the Doorway',2001),
	('2020',2020),
	('Lover',2019),
	('My World Is Over',2004),
	('Nina Cried Power',2018),
	('The Night We Called It a Day', 2015),
	('Kamikaze', 2018),
	('Invincible', 2001);
-- Заполняем таблицу исполнители/альбомы
INSERT INTO 
	singersalbums (singer_id, album_id)
VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,9),
	(9,8),
	(10,10),
	(1,11);
-- Заполняем таблицу треки
INSERT INTO 
	tracks (name, duration, album_id)
VALUES
	('Remember the Time', 205, 1),
	('Americano', 247, 2),
	('In My Defence', 232, 3),
	('Barcelona', 342, 3),
	('God Gave Me Everything', 214, 4),
	('Blood in the Water', 358, 5),
	('Cornelia Street', 287, 6),
	('My World Is Over', 242, 8),
	('Shrike', 300, 8),
	('The Night We Called It a Day', 205, 9),
	('Fall', 262, 10),
	('You Rock My World', 339, 11),
	('Heaven Can Wait', 289, 11),
	('Heartbreaker', 310, 11),
	('Privacy', 305, 11);

INSERT INTO
	collections (name, year)
VALUES 
	('first',2015),
	('second',2016),
	('third',2017),	
	('fourth',2018),
	('fifth',2019),
	('sixth',2020),
	('seventh',2021),
	('eight',2022);
INSERT INTO	
	trackscollections (track_id, collection_id)
VALUES 
	(2,6),
	(5,1),
	(7,8),
	(1,3),
	(8,5),
	(9,2),
	(11,3),
	(15,5),
	(12,7),
	(4,8),
	(6,5),
	(8,4),
	(3,1),
	(5,7),
	(10,2),
	(15,4),
	(13,8);
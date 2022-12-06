TRUNCATE TABLE genres RESTART IDENTITY CASCADE;
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
	
TRUNCATE TABLE singers RESTART IDENTITY CASCADE;
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
	(10,6);

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
	('Remember the Time', 3.25, 1),
	('Americano', 4.07, 2),
	('In My Defence', 3.52, 3),
	('Barcelona', 5.42, 3),
	('God Gave Me Everything', 3.34, 4),
	('Blood in the Water', 5.58, 5),
	('Cornelia Street', 4.47, 6),
	('My World Is Over', 4.02, 8),
	('Shrike', 5.00, 8),
	('The Night We Called It a Day', 3.40, 9),
	('Fall', 4.22, 10),
	('You Rock My World', 5.39, 11),
	('Heaven Can Wait', 4.49, 11),
	('Heartbreaker', 5.10, 11),
	('Privacy', 5.05, 11);

INSERT INTO
	collections (name, year, track_id)
VALUES 
	('first',2015,4),
	('second',2016,14),
	('third',2017,2),	
	('fourth',2018,1),
	('fifth',2019,1),
	('sixth',2020,9),
	('seventh',2021,15),
	('eight',2022,14);

--название и год выхода альбомов, вышедших в 2018 году;
SELECT name, year FROM albums
WHERE YEAR = 2018;
--название и продолжительность самого длительного трека;
SELECT name, duration FROM tracks 
WHERE  duration = (SELECT max(duration) FROM  tracks);
--название треков, продолжительность которых не менее 3,5 минуты;
SELECT name, duration FROM tracks
WHERE duration >= 3.5;
--названия сборников, вышедших в период с 2018 по 2020 год включительно;
SELECT name, year FROM collections
WHERE YEAR BETWEEN 2018 AND 2020;
--исполнители, чье имя состоит из 1 слова;
SELECT * FROM singers
WHERE name NOT LIKE '% %';
--название треков, которые содержат слово "мой"/"my".
SELECT name FROM tracks
WHERE name LIKE '%My%';
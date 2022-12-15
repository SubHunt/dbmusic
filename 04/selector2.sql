--количество исполнителей в каждом жанре;
SELECT name, count(name)  FROM genres g
JOIN genressingers gs ON g.genre_id = gs.genre_id
GROUP BY name
ORDER BY count; 

--количество треков, вошедших в альбомы 2019-2020 годов;
SELECT t.name, count(t.name) FROM tracks t
JOIN albums a ON t.album_id = a.album_id
WHERE a.YEAR BETWEEN 2019 AND 2020
GROUP BY t.name;

--средняя продолжительность треков по каждому альбому;
SELECT a.name, avg(t.duration) FROM albums a
JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.name
ORDER BY a.name;

--все исполнители, которые не выпустили альбомы в 2020 году;
SELECT s.name, a.name FROM singers s
JOIN singersalbums sa ON s.singer_id = sa.singer_id
JOIN albums a ON sa.album_id = a.album_id
WHERE a.year <> 2020;

--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT c.name FROM collections c 
JOIN trackscollections tc ON c.collection_id = tc.collection_id
JOIN tracks t ON tc.track_id = t.track_id
JOIN albums a ON t.album_id = a.album_id 
JOIN singersalbums sa ON a.album_id = sa.album_id  
JOIN singers s ON sa.singer_id = s.singer_id
WHERE s.name = 'Michael Jackson';

--название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT a.name FROM albums a 
JOIN singersalbums sa ON a.album_id = sa.album_id 
JOIN singers s ON sa.singer_id = s.singer_id 
JOIN genressingers gs ON s.singer_id = gs.singer_id
GROUP BY a.name
HAVING count(gs.singer_id) >1;

--наименование треков, которые не входят в сборники;
SELECT t.name, t.track_id FROM tracks t 
LEFT JOIN trackscollections tc ON t.track_id = tc.track_id
WHERE tc.track_id IS NULL;

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT s.name Певец, t.name Трек, duration Продолжительность FROM singers s 
JOIN singersalbums sa ON s.singer_id = sa.singer_id 
JOIN albums a ON sa.album_id = a.album_id 
JOIN tracks t ON a.album_id = t.album_id
WHERE duration = (SELECT min(duration) FROM tracks)
GROUP BY s.name, t.name, duration;

--название альбомов, содержащих наименьшее количество треков.
SELECT a.name Альбом, count(t.track_id) Треков  FROM albums a
JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.name
HAVING  (SELECT count(t.track_id) <= 1);
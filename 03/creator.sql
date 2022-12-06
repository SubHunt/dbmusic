-- Создаем таблицу Жанры
CREATE TABLE IF NOT EXISTS genres (
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR(20) UNIQUE NOT NULL 
);

--Создаем таблицу Singers
CREATE TABLE IF NOT EXISTS singers (
	singer_id SERIAL PRIMARY KEY,
	name VARCHAR(20) UNIQUE NOT NULL
);

--Создаем таблицу GenresSingers
CREATE TABLE IF NOT EXISTS genressingers (
	singer_id INTEGER REFERENCES singers(singer_id),
	genre_id INTEGER REFERENCES genres(genre_id),
	CONSTRAINT pk PRIMARY KEY (singer_id, genre_id)
);

-- Создаем таблицу Альбомы
CREATE TABLE IF NOT EXISTS albums (
	album_id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL,
	year INTEGER NOT NULL
);

--Создаем таблицу SingersAlbums
CREATE TABLE IF NOT EXISTS singersalbums (
	singer_id INTEGER REFERENCES singers(singer_id),
	album_id INTEGER REFERENCES albums(album_id),
	CONSTRAINT pk_2 PRIMARY KEY (singer_id, album_id)
);

--Создаем таблицу Tracks
CREATE TABLE IF NOT EXISTS tracks (
	track_id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
	duration FLOAT(5) NOT NULL,
	album_id INTEGER REFERENCES albums(album_id)
);

--Создаем таблицу Collections
CREATE TABLE IF NOT EXISTS collections (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	year INTEGER NOT NULL,
	track_id INTEGER REFERENCES tracks(track_id)
) 


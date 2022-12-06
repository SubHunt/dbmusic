-- ������� ������� �����
CREATE TABLE IF NOT EXISTS genres (
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR(20) UNIQUE NOT NULL 
);

--������� ������� Singers
CREATE TABLE IF NOT EXISTS singers (
	singer_id SERIAL PRIMARY KEY,
	name VARCHAR(20) UNIQUE NOT NULL
);

--������� ������� GenresSingers
CREATE TABLE IF NOT EXISTS genressingers (
	singer_id INTEGER REFERENCES singers(singer_id),
	genre_id INTEGER REFERENCES genres(genre_id),
	CONSTRAINT pk PRIMARY KEY (singer_id, genre_id)
);

-- ������� ������� �������
CREATE TABLE IF NOT EXISTS albums (
	album_id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL,
	year INTEGER NOT NULL
);

--������� ������� SingersAlbums
CREATE TABLE IF NOT EXISTS singersalbums (
	singer_id INTEGER REFERENCES singers(singer_id),
	album_id INTEGER REFERENCES albums(album_id),
	CONSTRAINT pk_2 PRIMARY KEY (singer_id, album_id)
);

--������� ������� Tracks
CREATE TABLE IF NOT EXISTS tracks (
	track_id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
	duration FLOAT(5) NOT NULL,
	album_id INTEGER REFERENCES albums(album_id)
);

--������� ������� Collections
CREATE TABLE IF NOT EXISTS collections (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	year INTEGER NOT NULL,
	track_id INTEGER REFERENCES tracks(track_id)
) 


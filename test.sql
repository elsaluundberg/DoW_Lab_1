CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE song (
    song_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    length INT NOT NULL,
    album_id INT REFERENCES album(album_id)
);

CREATE TABLE album (
    album_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE artist_song (
    artist_id INT REFERENCES artists(artist_id) ON DELETE CASCADE,
    song_id INT REFERENCES song(song_id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, song_id)
);


----step1 CREATE--------------
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
    artist_id INT REFERENCES artists(artist_id) ON DELETE CASCADE, --Raderar kopplingen om artisten tas bort
    song_id INT REFERENCES song(song_id) ON DELETE CASCADE, --Raderar kopplingen om låten tas bort
    PRIMARY KEY (artist_id, song_id)
);

---step2 INSERT------------------------

--Lägg in artister i artists tabellen
INSERT INTO artists (name) VALUES ('Lady Gaga');
INSERT INTO artists (name) VALUES ('The Weeknd');
INSERT INTO artists (name) VALUES ('Adele');


---Lägg in album i album tabellen
INSERT INTO album (name) VALUES ('Chromatica');
INSERT INTO album (name) VALUES ('After Hours');
INSERT INTO album (name) VALUES ('30');

---Lägg in låtar i song tabellen
INSERT INTO song (name, length, album_id) VALUES ('Rain on Me', 180, 1);
INSERT INTO song (name, length, album_id) VALUES ('Blinding Lights', 200, 2);
INSERT INTO song (name, length, album_id) VALUES ('Easy on Me', 210, 3);

--Lägg in kopplingar mellan artister och låtar i artist_song tabellen
INSERT INTO artist_song (artist_id, song_id) VALUES (1, 1); --Lady Gaga - Rain on Me
INSERT INTO artist_song (artist_id, song_id) VALUES (2, 2); --The Weeknd - Blinding Lights
INSERT INTO artist_song (artist_id, song_id) VALUES (3, 3); --  Adele - Easy on Me

---step3 SELECT------------------------
--Hämta alla artister och deras låtar
SELECT * FROM artists;
SELECT * FROM song;
SELECT * FROM album;    

--step4 UPDATE------------------------
update artists set name = 'Ariana Grande' where artist_id = 1;
SELECT * FROM artists where artist_id = 1;

--step5 DELETE------------------------
DELETE FROM artists WHERE artist_id = 2; --Tar bort The Weeknd och kopplingen i artist_song tabellen    
SELECT * FROM artists;
SELECT * FROM artist_song; --Kopplingen mellan The Weeknd och Blinding Lights är borta
